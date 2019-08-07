module Ektar
  class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    scope :enable_organizations, -> { where(enable: true) }

    def self.list_name_available
      enable_organizations.map(&:id).join(",")
    end
  end
end
