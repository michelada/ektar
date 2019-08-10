require "test_helper"

module Ektar
  class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    def setup
      @organization = ektar_organizations(:main_organization)
    end

    test "should get index" do
      get organizations_path

      assert_response :success
    end

    test "should get new" do
      get new_organization_path

      assert_response :success
    end

    test "should get show" do
      get organization_path(@organization.id)

      assert_response :success
      assert_select ".input", value: @organization.name
    end

    test "should get edit" do
      get edit_organization_path(@organization.id)

      assert_response :success
      assert_select ".input", value: @organization.name
    end

    test "can create organization" do
      assert_difference "Ektar::Organization.count", 1 do
        post organizations_path(valid_organization)
      end

      assert_equal "Organization test", Ektar::Organization.last.name
    end

    test "can show organization" do
      get organization_path(@organization.id)

      assert_select "form"
      assert_select ".input", value: @organization.name
    end

    test "can update organization" do
      put organization_path(@organization.id), params: {organization: {name: "michelada"}}
      @organization.reload

      assert_equal "michelada", @organization.name
    end

    test "can delete organization" do
      organization_delete = ektar_organizations(:organization_delete)

      assert_difference "Organization.count", -1 do
        delete organization_path(organization_delete.id)
      end
    end

    def valid_organization
      {organization: {name: "Organization test", enable: true}}
    end
  end
end
