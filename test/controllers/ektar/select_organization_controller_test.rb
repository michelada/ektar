# typed: ignore
require "test_helper"

module Ektar
  class SelectOrganizationControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @admin_user = ektar_users(:admin_user)
    end

    test "user must select organization after sign_in" do
      sign_in @admin_user

      get root_path

      assert_response :success
      assert_equal @controller.controller_name, "select_organization"
      assert_equal @controller.action_name, "new"
    end

    test "user can change current_organization" do
      sign_in @admin_user

      put select_organization_path(1),
        params: {organization_id: @admin_user.organizations.last.global_id},
        headers: {"HTTP_REFERER": root_url}

      refute_nil cookies[COOKIE_NAME]
    end
  end
end
