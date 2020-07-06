# typed: ignore
require "test_helper"

module Ektar
  class ResetPasswordsControllerTest < ActionDispatch::IntegrationTest
    include ActionMailer::TestHelper

    test "it shows reset password form" do
      get ektar.new_reset_password_path

      assert_response :success
    end

    test "it receives an inexistant email" do
      post ektar.reset_password_path, params: {user: {email: ""}}

      assert_no_emails do
        assert_redirected_to "/"
      end
    end

    test "it receives an existing email" do
      user = ektar_users(:user)

      assert_emails 1 do
        post ektar.reset_password_path, params: {user: {email: user.email}}
      end

      assert_response :success

      user.reload

      refute_nil user.reset_password_token
    end
  end
end
