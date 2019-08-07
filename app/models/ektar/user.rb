module Ektar
  class User < ApplicationRecord
    validates :email, presence: true, format: {with: VALID_EMAIL} uniqueness: { case_sensitive: false }
    belongs_to :ektar_organization
    enum role: %i[admin member]

    VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  end
end
