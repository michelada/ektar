# typed: ignore
require "test_helper"

module Ektar
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    # def setup
    #   @profile = ektar_profiles(:first_profile)
    #   @user = ektar_users(:user)
    # end

    # test "should get new" do
    #   get user_profiles_path(@user.id)

    #   assert :success
    # end

    # test "should get edit" do
    #   get edit_user_profiles_path(@profile.id)

    #   assert :success
    #   assert_select ".input", value: @profile.name
    # end

    # test "can create profile" do
    #   assert_difference "Ektar::Profile.count", 1 do
    #     post user_profiles_path((@user.id)), params: {profile: valid_profile}
    #   end
    # end

    # def valid_profile
    #   {name: "Full name"}
    #   #  image_profile: page.attach_file("profile[image_profile]", Rails.root + file_fixture("profile.jpg"), visible: false)}
    # end
  end
end
