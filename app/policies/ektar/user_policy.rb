# typed: true
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?
      user_organization = user.present? && record.present?
      admin_membership = false

      if user_organization
        admin_membership = user.is_admin?(record)
      end

      user_organization && admin_membership
    end
  end
end
