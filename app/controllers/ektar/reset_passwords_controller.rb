# typed: false
# frozen_string_literal: true

module Ektar
  class ResetPasswordsController < ApplicationController
    extend T::Sig
    include Ektar::Concerns::Tokens

    layout "ektar/users"

    sig { void }
    def new
      @resource = Ektar::User.new
    end

    sig { void }
    def create
      email = secure_params[:email]
      user = Ektar::User.find_by(email: email)

      if user.present?
        user.update(reset_password_token: generate_reset_password_token(user.global_id))
        ResetPasswordMailer.with(host: full_host, user: user).reset.deliver_now
      end

      render :create
    end

    private

    sig { returns(String) }
    def redirect_path_after_reset
      Ektar.configuration.root_app_path || root_path
    end
    helper_method :redirect_path_after_reset

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit([:email, :password, :password_confirmation], memberships_attributes: [{organization_attributes: [:name]}])
    end
  end
end
