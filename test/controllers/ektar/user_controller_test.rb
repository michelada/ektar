require "test_helper"

module Ektar
  class UserControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
    end

    test "should get new" do
    end

    test "should get show" do
    end

    test "should get edit" do
    end

    test "can create user" do
    end

    test "can edit user" do
    end

    test "can delete user" do
    end

    def valid_user
      organization = ektar_organizations(:main_organization)
      {email: "mario@gmail.com",
       encrypted_password: "12345678",
       ektar_organization_id: organization.id,}
    end
  end
end
