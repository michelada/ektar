# typed: ignore
require "test_helper"

module Ektar
  class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "super_admin user should get index" do
      sign_in(ektar_users(:super_user))

      get organizations_path

      assert_response :success
    end

    test "normal user should not get index" do
      sign_in(ektar_users(:admin_user))

      get organizations_path

      assert_response :redirect
      assert_redirected_to users_path
    end

    test "super_admin should create organization" do
      sign_in(ektar_users(:super_user))

      post organizations_path, params: organization_params

      assert_redirected_to organizations_path
      assert_equal organization_params.dig(:organization, :name), Organization.last.name
    end

    test "user should not create organization" do
      sign_in(ektar_users(:admin_user))

      post organizations_path, params: organization_params(name: "new")

      assert_redirected_to users_path
      refute_equal "new", Organization.first.name
    end

    test "super_admin user should get edit organization" do
      sign_in(ektar_users(:super_user))

      put organization_path(Organization.first), params: organization_params(name: "edited")

      assert_redirected_to organizations_path
      assert_equal "edited", Organization.first.name
    end

    test "user should not edit organization" do
      sign_in(ektar_users(:admin_user))

      put organization_path(Organization.first), params: organization_params(name: "edited")

      assert_redirected_to users_path
      refute_equal "edited", Organization.first.name
    end

    test "super_admin user should destroy edit organization" do
      sign_in(ektar_users(:super_user))

      delete organization_path(Organization.last)

      assert_redirected_to organizations_path
      refute Organization.last.enable?
    end

    test "user should not destroy organization" do
      sign_in(ektar_users(:admin_user))

      delete organization_path(Organization.last)

      assert_redirected_to users_path
      assert Organization.last.enable?
    end

    def organization_params(attrs = {})
      {
        organization: {
          name: "Organization test",
          enable: true,
          plan: ektar_plans(:plan),
        }.merge(attrs),
      }
    end
  end
end
