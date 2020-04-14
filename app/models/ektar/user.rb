# typed: false
# frozen_string_literal: true

module Ektar
  class User < ApplicationRecord
    extend T::Sig
    include PgSearch::Model

    has_secure_password :password, validations: true

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_user_id, inverse_of: :user
    has_many :organizations, class_name: "Ektar::Organization", through: :memberships, source: :organization
    has_many :used_passwords, class_name: "Ektar::UsedPassword", foreign_key: :ektar_user_id

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false}
    validates :password, format: {with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/}, unless: proc { |user| user.password.blank? }
    validates :memberships, presence: true, if: ->(user) { !user.super_admin }
    validate :validate_unique_password, if: ->(user) { user.password_digest_changed? }

    accepts_nested_attributes_for :memberships, limit: 1, reject_if: :reject_empty_organization!

    after_create :store_password
    before_update :store_password, if: :password_digest_changed?

    scope :super_admins, -> { where(super_admin: true) }

    pg_search_scope :search_full, against: :email,
                                  using: {tsearch: {prefix: true, any_word: true}}

    sig { returns(String) }
    def to_param
      global_id
    end

    sig { returns(T::Boolean) }
    def blocked?
      blocked_at?
    end

    sig { params(organization: Ektar::Organization).returns(T::Boolean) }
    def is_member?(organization)
      organizations.include?(organization)
    end

    sig { returns(T::Boolean) }
    def admin?
      admin_of.any?
    end

    sig { params(organization: T.nilable(Ektar::Organization)).returns(T::Boolean) }
    def is_admin?(organization)
      admin_of.include?(organization)
    end

    sig { returns(Ektar::Organization::ActiveRecord_AssociationRelation) }
    def admin_of
      organizations.where(ektar_memberships: {ektar_user_id: id, role: "admin"})
    end

    sig { returns(T.nilable(Ektar::Membership)) }
    def membership
      memberships.first
    end

    private

    sig { returns(Ektar::UsedPassword) }
    def store_password
      if used_passwords.count == Ektar.configuration.password_retain_count
        UsedPassword.destroy_by(id: used_passwords.order(created_at: :asc).pluck(:id).first)
      end
      used_passwords.create(password_digest: password_digest)
    end

    sig { params(attributes: T::Hash[T.any(String, Symbol), T.any(String, T::Hash[String, String])]).returns(T::Boolean) }
    def reject_empty_organization!(attributes)
      attributes.dig(:organization_attributes, :name).blank?
    end

    sig { void }
    def validate_unique_password
      used_passwords.each do |used_password|
        bcrypt = ::BCrypt::Password.new(used_password.password_digest)
        hashed_value = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)

        errors.add(:password, :password_already_used) if hashed_value == used_password.password_digest
      end
    end
  end
end
