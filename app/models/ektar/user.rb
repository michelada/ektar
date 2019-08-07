module Ektar
  class User < ApplicationRecord
    validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: true
    enum role: %i[admin member]
  end
end
