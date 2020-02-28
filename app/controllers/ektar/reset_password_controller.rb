# typed: false

module Ektar
  class ResetPasswordController < ApplicationController
    extend T::Sig

    sig { void }
    def new
      invitation_token = params.dig(:invitation_token)
      @invitation = Ektar::Invitation.find_by(invitation_token: invitation_token)

      @resource = Ektar::User.new(email: T.must(@invitation).email)
      @resource.memberships.build.build_organization if @resource.present?

      render :new, layout: "ektar/users"
    end

    def create
      @resource = Ektar::User.new(secure_params).tap do |user|
        user.last_ip = format_ip(request.remote_ip)
        user.last_activity_at = Time.zone.now
      end

      if @resource.save
        update_session_cookie(user: @resource.reload, organization: @resource.organizations.first)
        redirect_to ektar_url_helpers.admin_users_path
      else
        @resource.memberships.build.build_organization if @resource.memberships.empty?
        render :new, layout: "ektar/users"
      end
    end

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit([:email, :password, :password_confirmation], memberships_attributes: [{organization_attributes: [:name]}])
    end
  end
end
