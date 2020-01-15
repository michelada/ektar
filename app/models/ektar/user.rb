# typed: true

module Ektar
  class User < ApplicationRecord
    has_many :ektar_memberships, class_name: "Ektar::Membership", foreign_key: :ektar_user_id
    has_many :ektar_organizations, class_name: "Ektar::Organization", through: :ektar_memberships

    has_one :ektar_profile, dependent: :delete, class_name: "Ektar::Profile", foreign_key: :ektar_user_id

    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false}

    enum role: %i[admin member]

    def to_param
      global_id
    end
  end
end
