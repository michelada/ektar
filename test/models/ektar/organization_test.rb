# typed: false
require "test_helper"

module Ektar
  class OrganizationTest < ActiveSupport::TestCase
    test "it can have more than one user" do
      subject = ektar_organizations(:organization)
      alternate_user = ektar_users(:alternate_user)

      assert_difference "subject.users.reload.size", 1 do
        subject.users << alternate_user
        subject.save
      end
    end

    test "organization has UUID different than ID" do
      subject = ektar_organizations(:organization)

      refute_equal subject.global_id, subject.id
    end

    test "organization can only have one plan" do
      subject = ektar_organizations(:alternate_organization)

      subject.plan = ektar_plans(:plan)

      refute_equal subject.reload.plan, ektar_plans(:plan)

      assert_equal subject.reload.plan, ektar_plans(:alternate_plan)
    end

    #   test "is valid" do
    #     subject = Organization.new valid_params

    #     assert subject.valid?
    #   end

    #   test "is invalid" do
    #     subject = Organization.new invalid_params

    #     refute subject.valid?
    #     assert_equal 1, subject.errors.count
    #   end

    #   test "is invalid without unique name" do
    #     organization = ektar_organizations(:main_organization)
    #     subject = Organization.new valid_params.merge(name: organization.name)

    #     refute subject.valid?
    #     assert_equal 1, subject.errors.count
    #   end

    #   def valid_params
    #     {name: "Sample Organization"}
    #   end

    #   def invalid_params
    #     {}
    #   end
  end
end
