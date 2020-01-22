# typed: ignore
require "test_helper"

module Ektar
  class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    def setup
      @headers = {headers: http_login}
      @organization = ektar_organizations(:organization)
    end

    test "should get index" do
      get organizations_path, @headers

      assert_response :success
    end

    test "should get new" do
      get new_organization_path, @headers

      assert_response :success
    end

    test "should get show" do
      get organization_path(@organization.global_id)

      assert_response :success
      assert_select "h2", value: "Organización"
    end

    test "should get edit" do
      get edit_organization_path(@organization.global_id), @headers

      assert_response :success
      assert_select ".input", value: @organization.name
    end

    test "can create organization" do
      skip
      assert_difference "Ektar::Organization.count", 1 do
        post organizations_path, {params: valid_organization, headers: http_login}

        assert_response :success
      end

      assert_equal "Organization test", Ektar::Organization.last.name
    end

    test "can show organization" do
      get organization_path(@organization.global_id)

      assert_response :success
      assert_select "h2", "Organización"
    end

    test "can update organization" do
      put organization_path(@organization.global_id), {params: {organization: {name: "Fixture Organization"}}, headers: http_login}
      @organization.reload

      assert_equal "Fixture Organization", @organization.name
    end

    test "can delete organization" do
      organization_delete = ektar_organizations(:alternate_organization)

      assert_no_difference "Organization.count", -1 do
        delete organization_path(organization_delete.global_id), @headers
      end

      refute organization_delete.reload.enable
    end

    def valid_organization
      {organization: {name: "Organization test", enable: true, plan: ektar_plans(:plan)}}
    end

    def http_login
      username = "manager"
      password = "secrets"
      {HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}
    end
  end
end
