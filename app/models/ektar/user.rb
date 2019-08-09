module Ektar
  class User < ApplicationRecord
    belongs_to :organization, class_name: 'Ektar::Organization', foreign_key: :ektar_organization_id
    has_one :ektar_profile, dependent: :destroy
    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: true
    validates :encrypted_password, presence: true, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}/i}
    enum role: %i[admin member]
  end
end
