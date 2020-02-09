# typed: false
# frozen_string_literal: true

module Ektar
  class InvitationsController < ApplicationController
    extend T::Sig

    sig { void }
    def create
      organization = Ektar::Organization.find_by(id: params.dig(:user, :organization_id))

      membership = T.must(organization).memberships.new.tap do |invited_membership|
        @new_user = invited_membership.build_user(new_user_params).tap do |invited_user|
          verifier = ActiveSupport::MessageVerifier.new("s3cr3t")

          invited_user.invitation_token = verifier.generate(T.must(organization).global_id)
          invited_user.invitation_created_at = Time.zone.now
          invited_user.password_digest = SecureRandom.hex
        end
      end

      if @new_user.save && membership.save
        Ektar::UserMailer.with(user: @new_user, current_user: current_user).new_invitation_email.deliver_now
        flash[:notice] = t("flash.create.invitation.notice", email: @new_user.email)
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
