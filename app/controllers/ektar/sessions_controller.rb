# typed: true
require_dependency "ektar/application_controller"

module Ektar
  class SessionsController < ApplicationController
    def new
      @resource = Ektar::User.new

      render :new, layout: "ektar/users"
    end

    def create
      @resource = User.find_by(email: params.dig(:user, :email))

      if @resource&.authenticate(params.dig(:user, :password))
        @resource.update last_ip: format_ip(request.remote_ip), last_activity_at: Time.zone.now
        cookies.encrypted[session_cookie] = {value: @resource.global_id, expires: Ektar.configuration.session_expiration}

        set_flash(klass: "session", action: action_name)
        redirect_to root_path
      else
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
