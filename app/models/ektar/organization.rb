module Ektar
  class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :ektar_users, depend: :destroy
  end
end
