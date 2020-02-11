# typed: true

module Ektar
  class SelectOrganizationController < ApplicationController
    sig { void }
    def create
      organization_id = params.dig(:organization, :organization_id)

      @organization = Ektar::Organization.joins(:users).find_by(global_id: organization_id)
      update_session_cookie(user: T.must(current_user), organization: @organization)

      redirect_to request.referer
    end
  end
end
