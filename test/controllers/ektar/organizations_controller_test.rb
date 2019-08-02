require "test_helper"

module Ektar
  class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get organizations_path

      assert_response :success
    end
  end
end
