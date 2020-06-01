# typed: true
# frozen_string_literal: true

module Ektar
  class UserPolicy < ApplicationPolicy
    def index?
      # has_organization = user.present? && record.present?

      # admin_membership = has_organization && user.is_admin?(record)

      # has_organization && admin_membership || user&.super_admin?
      true
    end

    def destroy?
      resource, organization = record
      organization&.has_active_user?(resource) || super_admin?
    end

    private

    def super_admin?
      @super_admin ||= user&.super_admin? if @super_admin.nil?
      @super_admin
    end
  end
end
