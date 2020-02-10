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
      assert_emails 1 do
        get new_invitation_path(organization_id: @organization, email: "test_invitation@ektar.com")
      end
    end
  end
end
