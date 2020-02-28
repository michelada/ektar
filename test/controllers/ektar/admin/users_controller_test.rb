# typed: ignore
require "test_helper"

module Ektar
  module Admin
    class UsersControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @user = ektar_users(:admin_user)
      end

      test "should get index" do
        sign_in(@user)

        get admin_users_path

        assert_response :success
      end

      test "should get new" do
        sign_in(@user)

        get new_super_admin_user_path

        assert_response :success
      end

      test "should get show" do
        sign_in(@user)

        get super_admin_user_path(@user)

        assert_response :success
      end

      test "should get edit" do
        sign_in(@user)

        get edit_super_admin_user_path(@user)

        assert_response :success
      end

      test "should put update" do
        sign_in(@user)

        put super_admin_user_path(@user), params: user_params

        assert_response :redirect
        assert_redirected_to super_admin_users_path
      end

      test "should perform a logical delete" do
        sign_in(@user)

        assert_no_difference "Ektar::User.count" do
          delete super_admin_user_path(@user)
        end

        assert @user.reload.blocked_at?
        assert_response :redirect
        assert_redirected_to super_admin_users_path
      end

      test "shoud redirect to sign in when user not logged" do
        get admin_users_path

        assert_redirected_to new_session_path
      end

      test "should list organization users for logged user" do
        sign_in(ektar_users(:admin_user))

        get admin_users_path

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
end
