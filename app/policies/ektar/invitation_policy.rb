# typed: true
# frozen_string_literal: true

module Ektar
  class InvitationPolicy < ApplicationPolicy
    def create?
      super_admin? || admin_membership?
    end

    def update?
      super_admin? || admin_membership?
    end
  end
end
