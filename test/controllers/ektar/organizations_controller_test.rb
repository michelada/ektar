require "test_helper"

module Ektar
  class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      get organizations_path

      assert_response :success
    end

    test 'should get new' do
      get new_organization_path
      
      assert_response :success
    end

    test 'should get update' do
    end
    
    test 'should get show' do
    end

    test 'should create new organization' do
    end
  end
end
