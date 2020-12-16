# typed: ignore
# frozen_string_literal: true

module Ektar
  class AcceptInvitationsController < ApplicationController
    include Ektar::Concerns::Tokens

    sig { void }
    def new
      invitation_token = params[:token]
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if invitation_token.blank?

      organization_global_id = verify_invitation_token_from_url(invitation_token)
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if organization_global_id.blank?

      invitation = Ektar::Invitation
        .eager_load(:organization)
        .where(invitation_token: invitation_token, invitation_accepted_at: nil)
        .where(ektar_organizations: {global_id: organization_global_id})
        .order(created_at: :desc)
        .first
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if invitation.blank?

      user = Ektar::User
        .eager_load(memberships: :organization)
        .find_by(email: invitation.email)

      new_user = false
      if user.blank?
        user = build_user(invitation)
        new_user = true
      end

      if user.save
        invitation.invitation_accepted_at = Time.zone.now
        invitation.save

        user.reload
        reset_password_token = generate_reset_password_token(user.global_id)
        user.update_column(:reset_password_token, reset_password_token) if new_user
      end

      Rails.logger.info ">>> TOKEN : #{token_to_url(reset_password_token)}"
      redirect_to redirect_path_after_accept(token_to_url(reset_password_token))
    end

    private

    sig { params(token: String).returns(String) }
    def redirect_path_after_accept(token)
      main_app.edit_passwords_path(token: token)
    rescue
      ektar.edit_passwords_path(token: token)
    end

    sig { params(invitation: Ektar::Invitation).returns(Ektar::User) }
    def build_user(invitation)
      Ektar::User.new(email: invitation.email, password: SecureRandom.base64(15)).tap do |user|
        user.memberships.build(organization: invitation.organization)
        return user
      end
    end
  end
end
