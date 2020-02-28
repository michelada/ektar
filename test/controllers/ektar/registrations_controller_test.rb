# typed: ignore

require "test_helper"

module Ektar
  module Admin
    class RegistrationsControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      test "should register user and organization with valid params" do
        post registrations_path, params: user_params

        assert_redirected_to new_admin_select_plan_path
        assert cookies[COOKIE_NAME]

        registered_user = User.last

        assert_equal 1, registered_user.memberships.size
        assert registered_user.memberships.first.admin?
        assert_equal 1, registered_user.used_passwords.size

        refute_nil registered_user.last_ip
        refute_nil registered_user.last_activity_at
      end

      test "should not register user and organization with invalid params" do
        post registrations_path, params: user_params(email: nil)

        assert_response :success
        assert_nil cookies[COOKIE_NAME]
      end

      private

      def user_params(attrs = {})
        {user: {
          email: "user@example.com",
          password: "Password17",
          memberships_attributes: [organization_attributes: {name: "My Organization"}],
        }.merge(attrs)}
      end
    end
  end
end
