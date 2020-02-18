# typed: ignore
require "test_helper"

module Ektar
  class SelectPlanControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include LoginHelper

    setup do
      @user = ektar_users(:user)
      @plan = ektar_plans(:plan)
    end

    test "user is redirected to select a plan for organization" do
      sign_in @user

      get root_path
      follow_redirect!

      assert_redirected_to new_select_plan_path
    end

    test "user is not redirected when organization has plan" do
      sign_in ektar_users(:admin_user)

      get root_path
      follow_redirect!

      assert_equal "index", @controller.action_name
      assert_equal "users", @controller.controller_name
    end

    test "user can select a plan for organization" do
      sign_in @user

      post select_plan_index_path, params: {plan_id: @plan.id}

      assert_equal @user.organizations.first.plan, @plan
    end
  end
end
