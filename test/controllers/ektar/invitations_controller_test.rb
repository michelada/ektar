# typed: ignore
require "test_helper"

module Ektar
  class InvitationsControllerTest < ActionDispatch::IntegrationTest
    include ActionMailer::TestHelper
    include Engine.routes.url_helpers
    include LoginHelper

    def setup
      @organization = ektar_organizations(:organization)
    end

    test "should get new" do
      sign_in ektar_users(:admin_user)
      get new_invitation_path

      assert_response :success
    end

    test "can create invitation" do
      assert_difference "Ektar::Invitation.count", 1 do
        post invitations_path, params: invitation_params
      end

      assert_response :redirect
      assert_redirected_to users_path
    end

    test "it sends an email when an invitation is created" do
      assert_emails 1 do
        post invitations_path, params: invitation_params
      end
    end

    private

    def invitation_params(attrs = {})
      {invitation: {
        ektar_organization_id: @organization.id,
        email: "test_invitation@ektar.com",
        invitation_token: "BAhJIilkZjQyMmU2ZC05YjEzLTQ2ZDYtOTMxMy05ODhlMGU4NWI2MGYGOgZFVA==--d13b3574adbe29c7bc0a3a319cab33c6aecabd52",
      }.merge(attrs)}
    end
  end
end
