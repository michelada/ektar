# typed: ignore
require "test_helper"

module Ektar
  class SessionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include LoginHelper

    test "normal user is redirected_to [ND]" do
      skip # ND
    end

    test "admin user is redirected_to users#index" do
      sign_in ektar_users(:admin_user)
      get root_path

      assert_redirected_to users_path
    end

    test "super_admin user is redirected to organizations#index" do
      sign_in ektar_users(:super_user)
      get root_path

      assert_equal "index", @controller.action_name
      assert_equal "organizations", @controller.controller_name
    end

    test "blocked user can not log in" do
      blocked_user = ektar_users(:super_user)

      post sessions_path, params: {user: {email: blocked_user.email, password: blocked_user.password_digest}}

      assert_equal "sessions", @controller.controller_name
      assert_equal I18n.t("flash.create.session.alert"), flash[:alert]
    end
  end
end
