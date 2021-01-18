# typed: ignore
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

    def index?(current_organization = nil)
      swap_resource!(current_organization)

      false
    end

    def show?(current_organization = nil)
      swap_resource!(current_organization)

      false
    end

    def create?(current_organization = nil)
      swap_resource!(current_organization)

      false
    end

    def new?(current_organization = nil)
      create?(current_organization)
    end

    def update?(current_organization = nil)
      swap_resource!(current_organization)

      false
    end

    def edit?(current_organization = nil)
      update?(current_organization)
    end

    def destroy?(current_organization = nil)
      swap_resource!(current_organization)

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

      membership = resource.memberships.detect { |membership| membership.ektar_organization_id == organization.id && membership.blocked_at.nil? }
      membership.present?
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

    protected

    def swap_resource!(current_organization)
      if !@organization.is_a?(Ektar::Organization) && current_organization.present?
        @resource = @organization
        @organization = current_organization
      end
    end
  end
end
