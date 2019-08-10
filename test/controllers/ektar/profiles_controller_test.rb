require 'test_helper'

module Ektar
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def setup
      @profile = ektar_profiles(:first_profile)
    end

    test "should get index" do
      get profiles_path

      assert :success
    end

    test "should get new" do
      get new_profile_path

      assert :success
    end

    test "should get edit" do
      get edit_profile_path(@profile.id)

      assert :success
      assert_select ".input", value: @profile.name
    end

    test "can create profile" do
    end
    test "can show profile" do
    end
    test "can update profile" do
    end
    test "can delete profile" do
    end

    def valid_profile
    end
  end
end
