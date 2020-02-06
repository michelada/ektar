# typed: true
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?
      user_organization = user.present? && record.present?
      admin_membership = false

      if user_organization
        admin_membership = record
          .memberships
          .where(user: user)
          .where(role: "admin")
          .exists?
      end

      user_organization && admin_membership
    end
  end
end
