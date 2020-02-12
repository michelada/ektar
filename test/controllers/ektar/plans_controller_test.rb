# typed: ignore
require "test_helper"
require "support/login_helper"

module Ektar
  class PlansControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include LoginHelper

    def setup
      @plan = ektar_plans(:plan)

      sign_in(ektar_users(:super_user))
    end

    test "should get index" do
      get plans_path

      assert_response :success
    end

    test "should get new" do
      get new_plan_path

      assert_response :success
    end

    test "should get show" do
      get plan_path(@plan.id)

      assert_response :success
      assert_select ".control", value: @plan.name
    end

    test "should get edit" do
      get edit_plan_path(@plan.id)

      assert_response :success
      assert_select ".input", value: @plan.name
    end

    test "can create plan" do
      assert_difference "Ektar::Plan.count", 1 do
        post plans_path, {params: valid_plan}
      end

      assert_equal "Plan test", Ektar::Plan.last.name
    end

    test "can show plan" do
      get plan_path(@plan.id)

      assert_select ".control"
      assert_select "span", value: @plan.name
    end

    test "can update plan" do
      put plan_path(@plan.id), {params: {plan: {name: "Test"}}}
      @plan.reload

      assert_equal "Test", @plan.name
    end

    test "can delete plan" do
      plan_delete = ektar_plans(:plan_delete)

      assert_no_difference "Plan.count", -1 do
        delete plan_path(plan_delete.id)
      end

      assert_equal false, plan_delete.reload.active
    end

    def valid_plan
      {plan: {name: "Plan test"}}
    end
  end
end
