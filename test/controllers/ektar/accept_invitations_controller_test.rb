# typed: ignore
require "test_helper"

module Ektar
  class AcceptInvitationsControllerTest < ActionDispatch::IntegrationTest
    extend T::Sig
    include Engine.routes.url_helpers
    include Ektar::Concerns::Tokens

    test "NEW: without invitation token gets redirected" do
      get accept_invitations_path

      assert_redirected_to Ektar.configuration.root_app_path
    end

    test "NEW: gets redirected with unverificable token" do
      get accept_invitations_path(token: "random-token")

      assert_redirected_to Ektar.configuration.root_app_path
    end

    test "NEW: gets redirected when invitation can't found" do
      organization = ektar_organizations(:organization)
      invitation_token = generate_invitation_token(organization.global_id)

      get accept_invitations_path(token: token_to_url(invitation_token))

      assert_redirected_to Ektar.configuration.root_app_path
    end

    test "NEW: invitation found" do
      invitation = build_invitation

      get accept_invitations_path(token: token_to_url(invitation.invitation_token))

      assert_response :success
    end

    test "NEW: gets redirected when invitation already accepted" do
      invitation = build_invitation(invitation_params: {invitation_accepted_at: Time.now})

      get accept_invitations_path(token: token_to_url(invitation.invitation_token))

      assert_redirected_to Ektar.configuration.root_app_path
    end

    test "UPDATE: accepts invitation for new user" do
      invitation = build_invitation

      patch accept_invitations_path(
        params: {
          invitation: {
            invitation_token: token_to_url(invitation.invitation_token)
          }
        }
      )

      user = Ektar::User.find_by(email: invitation.email)
      refute_nil user

      assert_redirected_to edit_passwords_path(token: token_to_url(user.reset_password_token))
    end

    test "UPDATE: accepts invitation for existing user" do
      user = ektar_users(:user)
      invitation = build_invitation(invitation_params: {email: user.email})

      patch accept_invitations_path(
        params: {
          invitation: {
            invitation_token: token_to_url(invitation.invitation_token)
          }
        }
      )

      assert_redirected_to Ektar.configuration.root_app_path
    end

    private

    sig { params(invitation_params: T::Hash[Symbol, T.untyped]).returns(Ektar::Invitation) }
    def build_invitation(invitation_params: {})
      organization = ektar_organizations(:organization)
      invitation_token = generate_invitation_token(organization.global_id)

      default_params = {
        email: "invitation@example.org",
        organization: organization,
        invitation_token: invitation_token
      }

      Ektar::Invitation.create(default_params.merge(invitation_params))
    end
  end
end
