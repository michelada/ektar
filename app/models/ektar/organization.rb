module Ektar
  class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :ektar_users, dependent: :destroy

    scope :enable_organizations, -> { where(enable: true) }

    def self.list_name_available
      enable_organizations.map(&:name).join(",")
    end
  end
end
