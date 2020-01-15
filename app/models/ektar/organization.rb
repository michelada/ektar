# typed: true

module Ektar
  class Organization < ApplicationRecord
    include PgSearch::Model

    has_many :ektar_memberships, class_name: "Ektar::Membership", foreign_key: :ektar_organization_id
    has_many :ektar_users, class_name: "Ektar::User", through: :ektar_memberships
    validates :name, presence: true, uniqueness: {case_sensitive: false}

    pg_search_scope :search_full, against: :name,
                                  using: {tsearch: {prefix: true, any_word: true}}

    def to_param
      global_id
    end
  end
end
