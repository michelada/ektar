# typed: false
# frozen_string_literal: true

module Ektar
  class AcceptInvitationsController < ApplicationController
    sig { void }
    def new
      invitation_token = params[:token]
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if invitation_token.blank?

      verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
      organization_global_id = verifier.verified(invitation_token)
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
        user.update_column(:reset_password_token, generate_reset_password_token(user)) if new_user
      end

      redirect_to main_app.respond_to?(:new_reset_password_path) ? main_app.new_reset_password_path : ektar.new_reset_password_path
    end

    private

    def generate_reset_password_token(user)
      verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
      verifier.generate(user.global_id, expires_in: 7.days, purpose: :reset_password)
    end

    def build_user(invitation)
      Ektar::User.new(email: invitation.email, password: SecureRandom.base64(15)).tap do |user|
        user.memberships.build(organization: invitation.organization)
        return user
      end
    end
  end
end
