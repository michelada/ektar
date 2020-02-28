# typed: ignore
require "test_helper"

module Ektar
  module SuperAdmin
    class PlansControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      test "super_admin user should get index" do
        sign_in(ektar_users(:super_user))

        get super_admin_plans_path

        assert_response :success
      end

      test "normal user should not get index" do
        sign_in(ektar_users(:admin_user))

        get super_admin_plans_path

        assert_response :redirect
        assert_redirected_to root_path
      end

      test "super_admin should create plan" do
        sign_in(ektar_users(:super_user))

        post super_admin_plans_path, params: plan_params

        assert_redirected_to super_admin_plans_path
        assert_equal plan_params.dig(:plan, :name), Plan.last.name
      end

      test "user should not create plan" do
        sign_in(ektar_users(:admin_user))

        post super_admin_plans_path, params: plan_params(name: "new")

        assert_redirected_to root_path
        refute_equal "new", Plan.first.name
      end

      test "super_admin user should get edit plan" do
        sign_in(ektar_users(:super_user))

        put super_admin_plan_path(Plan.first), params: plan_params(name: "edited")

        assert_redirected_to super_admin_plans_path
        assert_equal "edited", Plan.first.name
      end

      test "user should not edit plan" do
        sign_in(ektar_users(:admin_user))

        put super_admin_plan_path(Plan.first), params: plan_params(name: "edited")

        assert_redirected_to root_path
        refute_equal "edited", Plan.first.name
      end

      test "super_admin user should destroy edit plan" do
        sign_in(ektar_users(:super_user))

        delete super_admin_plan_path(Plan.last)

        assert_redirected_to super_admin_plans_path
        refute Plan.last.active?
      end

      test "user should not destroy plan" do
        sign_in(ektar_users(:admin_user))

        delete super_admin_plan_path(Plan.last)

        assert_redirected_to root_path
        assert Plan.last.active?
      end

      def plan_params(attrs = {})
        {plan: {name: "Plan test"}.merge(attrs)}
      end
    end
  end
end
