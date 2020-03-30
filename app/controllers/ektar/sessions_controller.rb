# typed: false
require_dependency "ektar/application_controller"

module Ektar
  class SessionsController < ApplicationController
    def new
      @resource = Ektar::User.new

      render :new, layout: "ektar/users"
    end

    def create
      user_email = params.dig(:user, :email)
      @resource = User.find_by(email: user_email)

      if @resource&.authenticate(params.dig(:user, :password)) && !@resource.blocked_at?
        @resource.update last_ip: format_ip(request.remote_ip), last_activity_at: Time.zone.now

        update_session_cookie(user: @resource)

        set_flash(klass: "session", action: action_name)

        redirect_to after_sign_in_path
      else
        @resource = Ektar::User.new(email: user_email)
        set_flash(errors: true, klass: "session", action: action_name)

        render :new, layout: "ektar/users"
      end
    end

    def after_sign_in_path
      if super_admin?
        ektar.organizations_path
      elsif current_user
        if current_user.organizations.size > 1
          ektar.new_select_organization_path
        else
          organization = current_user.organizations.first
          update_session_cookie(organization: organization)

          Ektar.configuration.root_app_path || ektar.root_path
        end
      else
        ektar.new_registration_path
      end
    end

    def destroy
      if cookies.delete(session_cookie_name)
        @current_user = nil
        set_flash(klass: "session", action: action_name)
      else
        set_flash(errors: true, klass: "session", action: action_name)
      end
      redirect_to Ektar.configuration.sign_out_path || Ektar.configuration.root_path || ektar.new_session_path
    end
  end
end
