# typed: ignore
require "test_helper"

module Ektar
  class SessionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include LoginHelper

    test "normal user is redirected_to [ND]" do
      sign_in ektar_users(:regular_user)

      get root_path

      assert_includes @response.location, Ektar.configuration.root_app_path
    end

    test "admin user is redirected_to users#index" do
      sign_in ektar_users(:user)
      get root_path

      assert_redirected_to admin_users_path
    end

    test "super_admin user is redirected to organizations#index" do
      sign_in ektar_users(:super_user)
      get root_path
      follow_redirect!

      assert_equal "index", @controller.action_name
      assert_equal "organizations", @controller.controller_name
    end

    test "blocked user can not log in" do
      blocked_user = ektar_users(:super_user)

      post sessions_path, params: {user: {email: blocked_user.email, password: "Password17"}}

      assert_equal "sessions", @controller.controller_name
      assert_equal I18n.t("flash.create.session.alert"), flash[:alert]
    end

    test "user can logout" do
      subject = ektar_users(:user)
      sign_in subject
      delete session_path(subject.global_id)

      assert_redirected_to new_session_path
    end
  end
end
