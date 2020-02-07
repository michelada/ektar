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

      if @resource&.authenticate(params.dig(:user, :password))
        @resource.update last_ip: format_ip(request.remote_ip), last_activity_at: Time.zone.now

        # TODO: Si un usuario tiene más de 1 organización hay que llevarlo a
        # una página dónde seleccione cuál quiere que sea la organización activa.
        default_organization = nil
        default_organization = @resource.organizations.first if @resource.memberships.size == 1

        cookies.encrypted[session_cookie_name] = {
          value: {
            user: @resource.global_id,
            organization: default_organization&.global_id,
          },
          expires: Ektar.configuration.session_expiration,
        }

        set_flash(klass: "session", action: action_name)
        redirect_to root_path
      else
        @resource = Ektar::User.new(email: user_email)
        set_flash(errors: true, klass: "session", action: action_name)

        render :new, layout: "ektar/users"
      end
    end

    def destroy
      if cookies.delete(session_cookie)
        set_flash(klass: "session", action: action_name)
      else
        set_flash(errors: true, klass: "session", action: action_name)
      end
      redirect_to root_path
    end
  end
end
