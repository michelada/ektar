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

    test 'should get show' do
      get organization_path

      assert_response :success
    end

    test 'should get edit' do
      get edit_organization_path

      assert_response :success
    end

    test 'can create organization' do
    end

    test 'can show organization' do
    end
    
    test 'can edit organization' do
    end

    test 'can delete organization' do
    end

    test 'can not show invalid organization' do
    end

    test 'can not edit invalid organization' do
    end

    test 'can not delete invalid organization' do
    end
  end
end
