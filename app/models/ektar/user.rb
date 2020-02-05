# typed: strict
# frozen_string_literal: true

module Ektar
  class User < ApplicationRecord
    extend T::Sig

    has_secure_password :password, validations: true

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_user_id, inverse_of: :user
    has_many :organizations, class_name: "Ektar::Organization", through: :memberships, source: :organization

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false}
    validates :password, presence: true, format: {with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/}, if: ->(user) { user.password.present? }
    validates :memberships, presence: true, if: ->(user) { !user.super_admin }

    accepts_nested_attributes_for :memberships, limit: 1, reject_if: :reject_empty_organization!

    sig { returns(String) }
    def to_param
      global_id
    end

    sig { returns(T::Boolean) }
    def blocked?
      blocked_at?
    end

    sig { params(organization: Ektar::Organization).returns(T::Boolean) }
    def member_of?(organization)
      organizations.include?(organization)
    end

    sig { params(organization: Ektar::Organization).returns(T::Boolean) }
    def admin_of?(organization)
      admin_of.include?(organization)
    end

    sig { returns(Ektar::Organization::ActiveRecord_AssociationRelation) }
    def admin_of
      organizations.where(ektar_memberships: {ektar_user_id: id, role: "admin"})
    end

    sig { returns(T::Boolean) }
    def admin?
      admin_of.any?
    end

    private

    sig { params(attributes: T::Hash[String, T.any(String, T::Hash[String, String])]).returns(T::Boolean) }
    def reject_empty_organization!(attributes)
      attributes.dig("organization_attributes", "name").blank?
    end
  end
end
