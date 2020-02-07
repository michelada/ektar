# typed: false
# frozen_string_literal: true

module Ektar
  class Organization < ApplicationRecord
    extend T::Sig
    include PgSearch::Model

    has_many :memberships, class_name: "Ektar::Membership", foreign_key: :ektar_organization_id
    has_many :users, class_name: "Ektar::User", through: :memberships, source: :user
    belongs_to :plan, class_name: "Ektar::Plan", foreign_key: :ektar_plan_id, optional: true
    validates :name, presence: true, uniqueness: {case_sensitive: false}

    pg_search_scope :search_full, against: :name,
                                  using: {tsearch: {prefix: true, any_word: true}}

    sig { returns(String) }
    def to_param
      global_id
    end

    sig { returns(Ektar::User::ActiveRecord_AssociationRelation) }
    def admins
      users.joins(:memberships).where(ektar_memberships: {role: "admin"})
    end

    sig { returns(Ektar::User::ActiveRecord_AssociationRelation) }
    def active_users
      users.where(blocked_at: nil)
    end

    sig { params(user: Ektar::User).returns(T::Boolean) }
    def has_active_user?(user)
      active_users.include?(user)
    end

    sig { returns(T::Boolean) }
    def admin?
      admins.any?
    end
  end
end
