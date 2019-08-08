require "test_helper"

module Ektar
  class UserControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    def setup
      @user = ektar_users(:first_user)
    end

    test "should get index" do
      get users_path

      assert_response :success
      assert_select "th", text: "Email"
    end

    test "should get new" do
      get new_user_path

      assert_response :success
      assert_select ".input"
    end

    test "should get show" do
      get users_path(@user.id)

      assert_response :success
    end

    test "should get edit" do
      get edit_user_path(@user.id)

      assert_response :success
      assert_select ".input", value: @user.email
      assert_select ".input"
    end

    test "can create user" do
      assert_difference "Ektar::User.count", 1 do
        post users_path, params: {user: valid_user}
      end
    end

    test "can edit user" do
      put user_path(@user.id), params: { user: {encrypted_password: "123123123"} }
      @user.reload

      assert_equal '123123123', @user.encrypted_password
    end

    test "can delete user" do
      second_user = ektar_users(:second_user)

      assert_difference "Ektar::User.count", -1 do
        delete user_path(second_user.id)
      end
    end

    def valid_user
      organization = ektar_organizations(:main_organization)
      {email: "mario@gmail.com",
       encrypted_password: "12345678",
       ektar_organization_id: organization.id}
    end
  end
end
