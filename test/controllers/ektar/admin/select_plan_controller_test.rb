# typed: ignore
require "test_helper"

module Ektar
  module Admin
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

        assert_response :redirect
        assert_redirected_to new_admin_select_plan_path
      end

      test "user must select plan even if he logs out" do
        sign_in @user
        delete session_path(@user.global_id)
        sign_in @user

        get root_path
        follow_redirect!

        assert_response :redirect
        assert_redirected_to new_admin_select_plan_path
      end

      test "user is not redirected when organization has plan" do
        sign_in ektar_users(:regular_user)

        get root_path
        follow_redirect!

        assert_equal "index", @controller.action_name
        assert_equal "users", @controller.controller_name
      end

      test "user can select a plan for organization" do
        sign_in @user

        post admin_select_plan_index_path, params: {plan_id: @plan.id}

        assert_equal @user.organizations.first.plan, @plan
      end
    end
  end
end
