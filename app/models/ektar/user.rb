# typed: strong

module Ektar
  class User < ApplicationRecord
    extend T::Sig

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_user_id
    has_many :organizations, class_name: "Ektar::Organization", through: :memberships, source: :organization

    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false}

    sig { returns(String) }
    def to_param
      global_id
    end

    sig { returns(T::Boolean) }
    def blocked?
      blocked_at?
    end
  end
end
