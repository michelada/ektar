# typed: ignore
require "test_helper"

module Ektar
  class SessionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def current_user
      @current_user ||= ektar_users(:user)
    end

    test "shoud redirect to sign in when user not logged" do
      get users_path

      assert_redirected_to registrations_path
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
