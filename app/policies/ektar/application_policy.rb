# typed: true
# frozen_string_literal: true

module Ektar
  class ApplicationPolicy
    attr_reader :user, :organization
    attr_accessor :resource

    def initialize(user, organization, resource = nil)
      @user = user
      @organization = organization
      @resource = resource
    end

    def index?
      false
    end

    def show?
      false
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
      false
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope.all
      end
    end

    def user_membership?
      return true if resource.nil?

      resource.memberships.where(ektar_organization_id: organization.id, blocked_at: nil).exists?
    end

    def admin_membership?
      if @admin_membership.nil?
        @admin_membership ||= begin
                                has_organization = user.present? && organization.present?
                                has_organization && user.is_admin?(organization)
                              end
      end
      @admin_membership
    end

    def super_admin?
      @super_admin ||= user&.super_admin? if @super_admin.nil?
      @super_admin
    end
  end
end
