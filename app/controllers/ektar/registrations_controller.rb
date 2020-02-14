# typed: false

require_dependency "ektar/application_controller"

module Ektar
  class RegistrationsController < ApplicationController
    extend T::Sig

    sig { void }
    def new
      @resource = T.let(Ektar::User.new, T.nilable(Ektar::User))
      @resource.memberships.build.build_organization if @resource.present?

      render :new, layout: "ektar/users"
    end

    sig { void }
    def create
      @resource = Ektar::User.new(secure_params).tap do |user|
        user.last_ip = format_ip(request.remote_ip)
        user.last_activity_at = Time.zone.now

        user.memberships.first.tap do |membership|
          if membership.present?
            membership.role = "admin"
            membership.owner = true
          end
        end
      end

      if @resource.save
        update_session_cookie(user: @resource, organization: @resource.organizations.first)
        redirect_to users_path
      else
        @resource.memberships.build(role: "admin").build_organization if @resource.memberships.empty?
        render :new, layout: "ektar/users"
      end
    end

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(:email, :password, :password_confirmation, memberships_attributes: [{organization_attributes: [:name]}])
    end
  end
end
