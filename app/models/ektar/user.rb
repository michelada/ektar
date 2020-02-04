# typed: strict
# frozen_string_literal: true

module Ektar
  class User < ApplicationRecord
    extend T::Sig

    has_secure_password :password, validations: true

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_user_id, inverse_of: :user
    has_many :organizations, class_name: "Ektar::Organization", through: :memberships, source: :organization

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false}
    validates :password, presence: true, format: {with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/, message: "Invalid format"}
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

    private

    sig { params(attributes: T::Hash[String, T.any(String, T::Hash[String, String])]).returns(T::Boolean) }
    def reject_empty_organization!(attributes)
      attributes.dig("organization_attributes", "name").blank?
    end
  end
end
