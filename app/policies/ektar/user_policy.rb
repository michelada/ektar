# typed: ignore
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?(current_organization = nil)
      swap_resource!(current_organization)
      super_admin? || admin_membership?
    end

    def new?(current_organization = nil)
      swap_resource!(current_organization)
      super_admin? || admin_membership?
    end

    def show?(current_organization = nil)
      swap_resource!(current_organization)
      super_admin? || admin_membership?
    end

    def destroy?(current_organization = nil)
      swap_resource!(current_organization)
      return false if user == resource

      (super_admin? || admin_membership?) && (user != resource && user_membership?)
    end
  end
end
