# typed: false
# frozen_string_literal: true

module Ektar
  class InvitationsController < ApplicationController
    extend T::Sig

    sig { void }
    def new
    end

    sig { void }
    def create
      organization_id = params.dig(:organization_id)
      user_email = params.dig(:email)
      organization = Ektar::Organization.find_by(global_id: organization_id)

      verifier = ActiveSupport::MessageVerifier.new("s3cr3t")
      invitation_token = verifier.generate(organization_id)

      invitation = Ektar::Invitation.new(organization: organization, email: user_email, invitation_token: invitation_token)
      if invitation.save
        Ektar::UserMailer.with(organization: organization, invitation_token: invitation_token, email: user_email).new_invitation_email.deliver_now
        flash[:notice] = t("flash.create.invitation.notice", email: user_email)
      else
        flash[:alert] = t("flash.create.invitation.alert")
      end

      redirect_to users_path
    end

    private

    sig { returns(ActionController::Parameters) }
    def new_user_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(:email)
    end
  end
end
