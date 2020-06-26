# typed: true
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?
      super_admin? || admin_membership?
    end

    def new?
      super_admin? || admin_membership?
    end

    def destroy?
      (super_admin? || admin_membership?) && (user != resource && user_membership?)
    end
  end
end
