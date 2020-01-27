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

    test "should add last_ip and last_activity_at to user" do
      post users_path, params: {user: valid_user}

      assert_equal Ektar::User.last.last_ip, "127.0.0.XXX"
      assert_equal Ektar::User.last.last_activity_at.to_s, Time.now.to_datetime.utc.to_s
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

    test "cannot create user without organization name" do
      assert_no_difference ["Ektar::User.count", "Ektar::Membership.count", "Ektar::Organization.count"], 1 do
        post users_path, params: {user: invalid_user}
      end
    end

    test "Only can create user with organization" do
      assert_difference ["Ektar::User.count", "Ektar::Membership.count", "Ektar::Organization.count"], 1 do
        post users_path, params: {user: valid_user}
      end

      assert_equal "example organization", Ektar::User.last.organizations.first.name
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
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       memberships_attributes: [organization_attributes: {name: "example organization"}],}
    end

    def invalid_user
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       memberships_attributes: [organization_attributes: {name: ""}],}
    end
  end
end
