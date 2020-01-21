# typed: ignore
require "test_helper"

module Ektar
  class PlansControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def setup
      @headers = {headers: http_login}
      @plan = ektar_plans(:plan)
    end

    test "should get index" do
      get plans_path, @headers

      assert_response :success
    end

    test "should get new" do
      get new_plan_path, @headers

      assert_response :success
    end

    test "should get show" do
      get plan_path(@plan.id)

      assert_response :success
      assert_select ".control", value: @plan.name
    end

    test "should get edit" do
      get edit_plan_path(@plan.id), @headers

      assert_response :success
      assert_select ".input", value: @plan.name
    end

    test "can create plan" do
      assert_difference "Ektar::Plan.count", 1 do
        post plans_path, {params: valid_plan, headers: http_login}
      end

      assert_equal "Plan test", Ektar::Plan.last.name
    end

    test "can show plan" do
      get plan_path(@plan.id)

      assert_select ".control"
      assert_select "span", value: @plan.name
    end

    test "can update plan" do
      put plan_path(@plan.id), {params: {plan: {name: "Test"}}, headers: http_login}
      @plan.reload

      assert_equal "Test", @plan.name
    end

    test "can delete plan" do
      plan_delete = ektar_plans(:plan_delete)

      assert_no_difference "Plan.count", -1 do
        delete plan_path(plan_delete.id), @headers
      end

      assert_equal false, plan_delete.reload.active
    end

    def valid_plan
      {plan: {name: "Plan test"}}
    end

    def http_login
      username = Ektar.configuration.organization_username
      password = Ektar.configuration.organization_password
      {HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(username, password)}
    end
  end
end
