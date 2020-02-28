# typed: false
require "test_helper"

module Ektar
  class OrganizationTest < ActiveSupport::TestCase
    test "is valid" do
      subject = Organization.new organization_params

      assert subject.valid?
    end

    test "is invalid" do
      subject = Organization.new

      refute subject.valid?
      assert_equal 1, subject.errors.count
    end

    test "is invalid without unique name" do
      organization = ektar_organizations(:organization)
      subject = Organization.new organization_params.merge(name: organization.name)

      refute subject.valid?
      assert_equal 1, subject.errors.count
    end

    test "it can have more than one user" do
      subject = ektar_organizations(:organization)
      regular_user = ektar_users(:regular_user)

      assert_difference("subject.users.reload.size", 1) do
        subject.users << regular_user
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

    test "organization can tel its users" do
      organization = ektar_organizations(:organization_no_plan)
      organization_user = ektar_users(:user)

      assert_includes organization.users, organization_user
    end

    test "organization can tell its admins" do
      organization = ektar_organizations(:organization)
      admin = ektar_users(:admin_user)

      assert_includes organization.admins, admin
    end

    test "organization can tell if it has any admin" do
      organization = ektar_organizations(:organization)

      assert organization.admin?
    end

    test "an organization can have many invitations" do
      organization = ektar_organizations(:organization)

      assert_difference "organization.invitations.count", 1 do
        @new_invitation = organization.invitations.create(email: "invited.user@ektar.com")
      end

      assert_includes organization.invitations, @new_invitation
    end

    private

    def organization_params(attrs = {})
      {name: "Sample Organization"}.merge(attrs)
    end
  end
end
