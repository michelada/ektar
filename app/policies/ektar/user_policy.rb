# typed: ignore
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?
      super_admin? || admin_membership?
    end

    def new?
      super_admin? || admin_membership?
    end

    def show?
      super_admin? || admin_membership?
    end

    def destroy?
      @resource ||= organization if organization.present?
      return false if user == resource

      (super_admin? || admin_membership?) && (user != resource && user_membership?)
    end
  end
end
