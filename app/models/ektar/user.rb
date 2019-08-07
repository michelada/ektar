module Ektar
  class User < ApplicationRecord
    belongs_to :ektar_organization
    VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
    validates :email, presence: true, format: {with: VALID_EMAIL}, uniqueness: {case_sensitive: false}
    enum role: %i[admin member]
  end
end
