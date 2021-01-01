# typed: ignore
# frozen_string_literal: true

module Ektar
  class OrganizationPolicy < ApplicationPolicy
    def index?
      user&.super_admin?
    end

    def show?
      user&.super_admin?
    end

    def create?
      false
    end

    def new?
      create?
    end

    def update?
      false
    end

    def edit?
      update?
    end

    def destroy?
      user&.super_admin?
    end
  end
end
