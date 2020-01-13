# typed: true

module Ektar
  class User < ApplicationRecord
    belongs_to :organization, class_name: "Ektar::Organization", foreign_key: :ektar_organization_id
    has_one :ektar_profile, dependent: :delete, class_name: "Ektar::Profile", foreign_key: :ektar_user_id

    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: {case_sensitive: false, scope: :ektar_organization_id}

    enum role: %i[admin member]
  end
end
