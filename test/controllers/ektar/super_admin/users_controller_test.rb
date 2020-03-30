# typed: ignore
require "test_helper"

module Ektar
  module SuperAdmin
    class UsersControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @user = ektar_users(:super_user)
        sign_in(@user)
      end

      test "should get index" do
        get super_admin_users_path

        assert_response :success
      end

      test "should get new" do
        get new_super_admin_user_path

        assert_response :success
      end

      test "should get show" do
        get super_admin_user_path(@user)

        assert_response :success
      end

      test "should get edit" do
        get edit_super_admin_user_path(@user)

        assert_response :success
      end

      test "should put update" do
        put super_admin_user_path(@user), params: user_params

        assert_response :redirect
        assert_redirected_to super_admin_users_path
      end

      test "should perform a logical delete" do
        assert_no_difference "Ektar::User.count" do
          delete super_admin_user_path(@user)
        end

        assert @user.reload.blocked_at?
        assert_response :redirect
        assert_redirected_to super_admin_users_path
      end

      private

      def user_params(attrs = {})
        {
          user: {
            email: "user@example.com",
            password: "Password17",
            memberships_attributes: [organization_attributes: {name: "My Organization"}]
          }.merge(attrs)
        }
      end
    end
  end
end
