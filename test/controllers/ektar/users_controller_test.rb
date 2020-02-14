# typed: ignore
require "test_helper"

module Ektar
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def current_user
      @current_user ||= ektar_users(:user)
    end

    test "should not register user and organization with invalid params" do
      post users_path, params: user_params(email: nil)

      assert_response :success
      assert_nil cookies[COOKIE_NAME]
    end

    # Organization Owner

    test "shoud redirect to sign in when user not logged" do
      get users_path

      assert_redirected_to registrations_path
    end

    test "should list organization users for logged user" do
      sign_in(ektar_users(:admin_user))

      get users_path

      assert_response :success
    end

    private

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
