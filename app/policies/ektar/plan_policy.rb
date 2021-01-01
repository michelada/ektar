# typed: ignore
# frozen_string_literal: true

module Ektar
  class PlanPolicy < ApplicationPolicy
    def index?
      user&.super_admin?
    end

    def show?
      user&.super_admin?
    end

    def create?
      user&.super_admin?
    end

    def new?
      create?
    end

    def update?
      user&.super_admin?
    end

    def edit?
      update?
    end

    def destroy?
      user&.super_admin?
    end
  end
end
