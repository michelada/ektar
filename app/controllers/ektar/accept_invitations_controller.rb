# typed: ignore
# frozen_string_literal: true

module Ektar
  class AcceptInvitationsController < ApplicationController
    layout "ektar/users"
    include Ektar::Concerns::Tokens
    before_action :load_invitation!

    sig { void }
    def new
    end

    sig { void }
    def update
      user = Ektar::User
        .eager_load(memberships: :organization)
        .find_by(email: @resource.email)

      new_user = user.blank?
      user = build_user(@resource) if new_user

      if user.save
        @resource.invitation_accepted_at = Time.zone.now
        @resource.save

        if new_user
          user.reload
          reset_password_token = generate_reset_password_token(user.global_id)

          user.update_column(:reset_password_token, reset_password_token)
        end
      end

      return redirect_to redirect_path_after_accept(token_to_url(reset_password_token)) if new_user

      redirect_to Ektar.configuration.root_app_path || ektar.root_path
    end

    private

    sig { void }
    def load_invitation!
      invitation_token = params[:token] || params.dig(:invitation, :invitation_token)
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if invitation_token.blank?

      organization_global_id = verify_invitation_token_from_url(invitation_token)
      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if organization_global_id.blank?

      @resource = Ektar::Invitation
        .eager_load(:organization)
        .where(invitation_token: token_from_url(invitation_token), invitation_accepted_at: nil)
        .where(ektar_organizations: {global_id: organization_global_id})
        .order(created_at: :desc)
        .first

      return redirect_to Ektar.configuration.root_app_path || ektar.root_path if @resource.blank?
    end

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
