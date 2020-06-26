# typed: ignore
require "test_helper"

module Ektar
  class PasswordsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "it redirects to root if edit has no token" do
      get edit_passwords_path

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it redirects to root if edit has an invalid token" do
      get edit_passwords_path(token: "invalid_token")

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it redirects to root if token has different purpose" do
      token = generate_token(purpose: :something_else)
      get edit_passwords_path(token: token)

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it redirects to root if token expired" do
      token = generate_token(expires_in: 1.minute)

      travel 2.minutes do
        get edit_passwords_path(token: token)
      end

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it redirect to root if user id does not exists" do
      token = generate_token(data: SecureRandom.uuid)

      get edit_passwords_path(token: token)

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it redirect to root if user token does not exists" do
      user = ektar_users(:user)
      token = generate_token(data: user.global_id)

      get edit_passwords_path(token: token)

      assert_equal I18n.t("flash.edit.passwords.alert_invalid_token"), flash[:alert]
      assert_redirected_to root_path
    end

    test "it shows form to reset password" do
      user = ektar_users(:user)
      token = generate_token(data: user.global_id)
      user.update_column(:reset_password_token, token)

      get edit_passwords_path(token: token)

      assert_nil flash[:alert]
      assert_response :success
    end

    test "it fails to change password when password and confirmation dont match" do
      user = load_user_with_token

      patch passwords_path(params: {
        reset_password_token: user.reset_password_token,
        password: "MyPassword",
        password_confirmation: "my password"
      })

      assert_equal I18n.t("flash.update.passwords.mismatch_confirmation"), flash.now[:alert]
      assert_response :success
    end

    test "it fails to change password when no password provided" do
      user = load_user_with_token

      patch passwords_path(params: {
        reset_password_token: user.reset_password_token,
        password: "",
        password_confirmation: ""
      })

      assert_equal I18n.t("activerecord.errors.models.ektar/user.attributes.password.invalid").capitalize, flash[:alert]
      assert_response :success
    end

    test "it fails to change password when reusing old password" do
      user = load_user_with_token
      password = "Chang3m&Pa$$w0r6"
      user.password = password
      user.save

      patch passwords_path(params: {
        reset_password_token: user.reset_password_token,
        password: password,
        password_confirmation: password
      })

      assert_equal I18n.t("activerecord.errors.models.ektar/user.attributes.password.password_already_used").capitalize, flash[:alert]
      assert_response :success
    end

    test "it updates user passwords and redirects to login" do
      user = load_user_with_token
      password = "Chang3m&Pa$$w0r6"

      patch passwords_path(params: {
        reset_password_token: user.reset_password_token,
        password: password,
        password_confirmation: password
      })

      assert_equal I18n.t("flash.update.passwords.notice"), flash[:notice]
      assert_redirected_to new_sessions_path
    end

    def load_user_with_token(key: :user)
      user = ektar_users(key)
      token = generate_token(data: user.global_id)
      user.update_column(:reset_password_token, token)

      user
    end

    def generate_token(data: "sample", purpose: :reset_password, expires_in: 2.minutes)
      verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
      verifier.generate(data, expires_in: expires_in, purpose: purpose)
    end
  end
end
