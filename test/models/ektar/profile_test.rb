require 'test_helper'

module Ektar
  class ProfileTest < ActiveSupport::TestCase
    test "is valid" do
      subject = Profile.new valid_params

      assert subject.valid?
    end

    test "is invalid" do
      subject = Profile.new valid_params.merge(name: "")

      refute subject.valid?
      assert_equal 1, subject.errors.count
    end

    test "is invalid user" do
      subject = Profile.new valid_params.merge(ektar_user_id: "")

      refute subject.valid?
      assert_equal 1, subject.errors.count
    end

    def valid_params
      user =  ektar_users(:first_user)
      {name: "User Example" , ektar_user_id: user.id}
    end
  end
end
