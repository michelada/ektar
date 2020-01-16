# typed: false

module Ektar
  class Organization < ApplicationRecord
    include PgSearch::Model

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_organization_id
    has_many :users, class_name: "Ektar::User", through: :memberships, source: :user
    belongs_to :plan, class_name: "Ektar::Plan", foreign_key: :ektar_plan_id
    validates :name, presence: true, uniqueness: {case_sensitive: false}

    pg_search_scope :search_full, against: :name,
                                  using: {tsearch: {prefix: true, any_word: true}}

    def to_param
      global_id
    end
  end
end
