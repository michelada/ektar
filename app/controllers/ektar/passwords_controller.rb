# typed: ignore
# frozen_string_literal: true

module Ektar
  class PasswordsController < ApplicationController
    include Ektar::Concerns::Tokens
    layout "ektar/users"
    before_action :verify_token!, :verify_and_load_user!

    sig { void }
    def edit
    end

    sig { void }
    def update
      password = secure_params[:password]
      password_confirmation = secure_params[:password_confirmation]

      @resource.password = password&.strip&.present? ? password&.strip : "_"
      @resource.password_confirmation = password_confirmation&.strip&.present? ? password_confirmation&.strip : "_"

      if @resource.valid?
        @resource.reset_password_token = nil
        return redirect_to redirect_path_after_update, notice: t("flash.update.passwords.notice") if @resource.save
      end

      flash.now[:alert] = if @resource.errors[:password_confirmation].any?
        t("flash.update.passwords.mismatch_confirmation")
      elsif @resource.errors[:password].any?
        @resource.errors[:password].first.capitalize
      else
        @resource.errors.first.capitalize
      end

      render :edit
    end

    private

    sig { params(password: T.nilable(String), password_confirmation: T.nilable(String)).returns(T::Boolean) }
    def validate_password_confirmation(password, password_confirmation)
      password == password_confirmation
    end

    sig { void }
    def verify_and_load_user!
      @token ||= params[:token] || params[:reset_password_token]
      Rails.logger.info ">>> TOKEN : #{token_from_url(@token)}"
      @global_id ||= verify_reset_password_token_from_url(@token)
      Rails.logger.info ">>> GLOBAL ID : #{@global_id}"

      @resource = load_user(@global_id, token_from_url(@token))
      Rails.logger.info ">>> RESOURCE: #{@resource}"
      if @resource.blank?
        redirect_to(redirect_path_on_failure, alert: t("flash.edit.passwords.alert_invalid_token"))
      end
    end

    sig { void }
    def verify_token!
      @token ||= params[:token] || params[:reset_password_token]
      @global_id ||= verify_reset_password_token_from_url(@token)
      Rails.logger.info ">>> GLOBAL ID (2): #{@global_id}"

      if @global_id.blank?
        redirect_to(redirect_path_on_failure, alert: t("flash.edit.passwords.alert_invalid_token"))
      end
    end

    sig { params(global_id: String, reset_password_token: String).returns(T.nilable(Ektar::User)) }
    def load_user(global_id, reset_password_token)
      Ektar::User.find_by(global_id: global_id, reset_password_token: reset_password_token)
    end

    sig { returns(String) }
    def redirect_path_on_failure
      main_app.root_path
    rescue
      ektar.root_path
    end

    sig { returns(String) }
    def redirect_path_after_update
      Ektar.configuration.sign_in_path || ektar.new_sessions_path
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.permit([:reset_password_token, :password, :password_confirmation])
    end
  end
end
