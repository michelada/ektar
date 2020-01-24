# typed: ignore
require "test_helper"

module Ektar
  class UserControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    def setup
      @user = ektar_users(:user)
    end

    test "should get index" do
      get users_path

      assert_response :success
      assert_select "th", text: "Id"
    end

    test "should get new" do
      get registration_path

      assert_response :success
      assert_select ".input"
    end

    test "should get show" do
      get users_path(@user.id)

      assert_response :success
    end

    test "should get edit" do
      get edit_user_path(@user.global_id)

      assert_response :success
      assert_select ".input", value: @user.email
      assert_select ".input"
    end

    test "can create user" do
      assert_difference "Ektar::User.count", 1 do
        post users_path, params: {user: valid_user}
      end
    end

    test "cannot create user without organization name" do
      assert_no_difference "Ektar::User.count", 1 do
        post users_path, params: { user: invalid_user }
      end
    end

    test "can edit user" do
      put user_path(@user.global_id), params: {user: {email: "mario+test@gmail.com"}}
      @user.reload

      assert_equal "mario+test@gmail.com", @user.email
    end

    test "can delete user" do
      alternate_user = ektar_users(:alternate_user)

      assert_difference "Ektar::User.count", -1 do
        delete user_path(alternate_user.global_id)
      end
    end

    def valid_user
      organization = ektar_organizations(:organization)
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       ektar_organization_id: organization.id,}
    end

    def invalid_user
      organization = ektar_organizations(:organization)
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       organization_attributes: { name: "" }}
    end
  end
end
