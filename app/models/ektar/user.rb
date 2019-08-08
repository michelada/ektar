module Ektar
  class User < ApplicationRecord
    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: true
    validates :encrypted_password, presence: true, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}/i}
    enum role: %i[admin member]
  end
end
