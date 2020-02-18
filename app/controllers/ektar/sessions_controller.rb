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

        # TODO: Si un usuario tiene más de 1 organización hay que llevarlo a
        # una página dónde seleccione cuál quiere que sea la organización activa.
        default_organization = @resource.organizations.first

        update_session_cookie(user: @resource, organization: default_organization)

        set_flash(klass: "session", action: action_name)
        redirect_to root_path
      else
        @resource = Ektar::User.new(email: user_email)
        set_flash(errors: true, klass: "session", action: action_name)

        render :new, layout: "ektar/users"
      end
    end

    def destroy
      if cookies.delete(session_cookie_name)
        @current_user = nil
        set_flash(klass: "session", action: action_name)
      else
        set_flash(errors: true, klass: "session", action: action_name)
      end
      redirect_to new_session_path
    end
  end
end
