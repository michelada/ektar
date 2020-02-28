# typed: true

module Ektar
  class InvitationPolicy < ApplicationPolicy
    def create?
      user_organization = user.present? && record.present?
      organization = Ektar::Organization.find_by(id: record.ektar_organization_id)
      admin_membership = false

      if user_organization && organization
        admin_membership = user.is_admin?(organization)
      end

      user_organization && admin_membership
    end

    def new?
      create?
    end

    def update?
      true
    end

    def edit?
      update?
    end
  end
end
