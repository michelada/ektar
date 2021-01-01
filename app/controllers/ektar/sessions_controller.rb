# typed: ignore
require_dependency "ektar/application_controller"

module Ektar
  class SessionsController < ApplicationController
    layout "ektar/users"

    def new
      redirect_to Ektar.configuration.root_app_path || ektar.root_path if current_user.present?

      @resource = Ektar::User.new
    end

    def create
      redirect_to Ektar.configuration.root_app_path || ektar.root_path if current_user.present?

      user_email = params.dig(:user, :email)
      @resource = User.find_by(email: user_email) if user_email.present?

      if @resource&.authenticate(params.dig(:user, :password)) && !@resource.blocked_at?
        @resource.update last_ip: format_ip(request.remote_ip), last_activity_at: Time.zone.now

        update_session_cookie(user: @resource)

        set_flash(klass: "session", action: action_name)

        redirect_to after_sign_in_path
      else
        @resource = Ektar::User.new(email: user_email)
        @resource.valid?

        set_flash(errors: true, klass: "session", action: action_name)

        respond_to do |format|
          format.json { render json: {errors: @resource.errors, flash: flash.alert || flash.notice, localtion: request.path}, status: :unprocessable_entity }
          format.html { render :new }
        end
      end
    end

    def after_sign_in_path
      if super_admin?
        ektar.super_admin_organizations_path
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
      if cookies.delete(session_cookie_name, domain: Ektar.configuration.session_domain)
        # Not sure why I have to delete the cookie twice but deleting it once does not work.
        cookies.delete(session_cookie_name, domain: Ektar.configuration.session_domain)
        @current_user = nil
        set_flash(klass: "session", action: action_name)
      else
        set_flash(errors: true, klass: "session", action: action_name)
      end
      redirect_to Ektar.configuration.sign_out_path || Ektar.configuration.root_path || ektar.new_sessions_path
    end
  end
end
