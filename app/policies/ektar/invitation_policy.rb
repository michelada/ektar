# typed: ignore
# frozen_string_literal: true

module Ektar
  class InvitationPolicy < ApplicationPolicy
    def create?(current_organization = nil)
      swap_resource!(current_organization)
      super_admin? || admin_membership?
    end

    def update?(current_organization = nil)
      swap_resource!(current_organization)
      super_admin? || admin_membership?
    end
  end
end
