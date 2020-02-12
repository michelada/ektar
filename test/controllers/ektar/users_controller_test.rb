# typed: ignore
require "test_helper"

module Ektar
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def current_user
      @current_user ||= ektar_users(:user)
    end

    # Registration cases

    test "should register user and organization with valid params" do
      post users_path, params: user_params

      assert_redirected_to users_path
      refute_nil cookies[COOKIE_NAME]

      registered_user = User.last

      assert_equal 1, registered_user.memberships.size
      assert registered_user.memberships.first.admin?
      assert_equal 1, registered_user.used_passwords.size

      refute_nil registered_user.last_ip
      refute_nil registered_user.last_activity_at
    end

    test "should not register user and organization with invalid params" do
      post users_path, params: user_params(email: nil)

      assert_response :success
      assert_nil cookies[COOKIE_NAME]
    end

    # Organization Owner

    test "shoud redirect to sign in when user not logged" do
      get users_path

      assert_redirected_to registration_path
    end

    test "should list organization users for logged user" do
      sign_in(ektar_users(:admin_user))

      get users_path

      assert_response :success
    end

    def user_params(attrs = {})
      {
        user: {
          email: "user@example.com",
          password: "Password17",
          memberships_attributes: [organization_attributes: {name: "My Organization"}],
        }.merge(attrs),
      }
    end
  end
end
