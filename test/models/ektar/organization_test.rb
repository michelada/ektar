# typed: false
require "test_helper"

module Ektar
  class OrganizationTest < ActiveSupport::TestCase
    test "it can have more than one user" do
      subject = ektar_organizations(:organization)
      alternate_user = ektar_users(:alternate_user)

      assert_difference "subject.ektar_users.reload.size", 1 do
        subject.ektar_users << alternate_user
        subject.save
      end
    end

      test "is valid" do
        subject = Organization.new valid_params

        assert subject.valid?
      end

      test "is invalid" do
        subject = Organization.new invalid_params

        refute subject.valid?
        assert_equal 1, subject.errors.count
      end

      test "is invalid without unique name" do
        organization = ektar_organizations(:organization)
        subject = Organization.new valid_params.merge(name: organization.name)

        refute subject.valid?
        assert_equal 1, subject.errors.count
      end

      def valid_params
        {name: "Sample Organization"}
      end

      def invalid_params
        {}
      end
  end
end
