# typed: true
# frozen_string_literal: true

module Ektar
  class InvitationsController < ApplicationController
    sig { void }
    def create
      organization = Ektar::Organization.find_by(id: params.dig(:user, :organization_id))

      membership = T.must(organization).memberships.new.tap do |invited_membership|
        @user = invited_membership.build_user(new_user_params).tap do |invited_user|
          invited_user.invitation_token = Time.zone.now.to_i
          invited_user.invitation_created_at = Time.zone.now
          invited_user.password_digest = ""
        end
      end

      if @user.save && membership.save
        flash[:notice] = t("flash.create.invitation.notice", email: @user.email)
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
