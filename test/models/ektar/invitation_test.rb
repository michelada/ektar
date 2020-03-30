# typed: false
require "test_helper"

module Ektar
  class InvitationTest < ActiveSupport::TestCase
    def setup
      @organization = ektar_organizations(:organization)
    end

    test "invitation is valid" do
      valid_invitation = Ektar::Invitation.new(invitation_params)

      assert valid_invitation.valid?
    end

    test "invitation is invalid" do
      invalid_invitation = Ektar::Invitation.new

      refute invalid_invitation.valid?
    end

    test "invitation is related to an organization" do
      assert_equal ektar_invitations(:pending_invitation).organization, @organization
      assert_equal ektar_invitations(:accepted_invitation).organization, @organization
    end

    test "invitation token equals to organization.global_id encrypted" do
      invitation = ektar_invitations(:pending_invitation)
      organization_id = invitation.organization.global_id

      verifier = ActiveSupport::MessageVerifier.new("s3cr3t")
      encrypted_token = verifier.verified(invitation.invitation_token)

      assert_equal encrypted_token, organization_id
    end

    test "invitations can tell if they were accepted" do
      assert ektar_invitations(:accepted_invitation).accepted?
      refute ektar_invitations(:pending_invitation).accepted?
    end

    private

    def invitation_params(attrs = {})
      {email: "invited_test@ektar.com",
       organization: @organization}.merge(attrs)
    end
  end
end
