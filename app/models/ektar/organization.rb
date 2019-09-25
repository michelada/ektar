module Ektar
  class Organization < ApplicationRecord
    include PgSearch::Model

    has_many :ektar_users, dependent: :delete_all, class_name: "Ektar::User", foreign_key: :ektar_organization_id
    validates :name, presence: true, uniqueness: true

    scope :enable_organizations, -> { where(enable: true) }
    pg_search_scope :search_full, against: :name,
                                  using: {tsearch: {prefix: true, any_word: true}}

    def self.list_name_available
      enable_organizations.map(&:id).join(",")
    end
  end
end
