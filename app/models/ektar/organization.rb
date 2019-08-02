module Ektar
  class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
  end
end
