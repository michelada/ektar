# typed: ignore
require "test_helper"

module Ektar
  class InvitationsControllerTest < ActionDispatch::IntegrationTest
    include ActionMailer::TestHelper
    include Engine.routes.url_helpers

    def setup
      @organization = ektar_organizations(:organization)
    end

    test "it sends an email when an invitation is created" do
      skip # Removed logic related to invitations by now
      assert_emails 1 do
        post invitations_path, params: {user: {organization_id: @organization.id, email: "test_invitation@ektar.com"}}
      end
    end
  end
end
