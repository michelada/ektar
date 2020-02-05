# typed: false
require "test_helper"

module Ektar
  class UserTest < ActiveSupport::TestCase
    test "it can belong to more than one organization" do
      subject = ektar_users(:user)
      alternate_organization = ektar_organizations(:alternate_organization)

      assert_difference "subject.organizations.reload.size", 1 do
        subject.organizations << alternate_organization
        subject.save
      end
    end

    test "to_param uses global_id" do
      subject = ektar_users(:user)

      refute_equal subject.to_param, subject.id
    end

    test "any new user is not super_admin" do
      user = Ektar::User.new

      refute user.super_admin?
    end

    test "any user can be updated to super_admin" do
      user = Ektar::User.new

      user.super_admin = true

      assert user.super_admin?
    end

    test "user password is invalid" do
      user = Ektar::User.new

      user.email = "user_with_invalid_password@example.com"
      user.password = "password"

      assert_not user.valid?
    end

    test "is valid" do
      subject = User.new valid_params

      assert subject.valid?
    end

    test "is invalid" do
      subject = User.new invalid_params_email

      refute subject.valid?
      assert_equal 2, subject.errors.count
    end

    test "is invalid without unique email" do
      user = ektar_users(:user)
      subject = User.new valid_params.merge(email: user.email)

      refute subject.valid?
      assert_equal 1, subject.errors.count
    end

    test "is invalid without valid organization" do
      subject = User.new invalid_params_organization
      refute subject.valid?

      assert_equal 1, subject.errors.count
    end

    test "user can be invited" do
      organization = ektar_organizations(:organization)

      assert_difference ["Ektar::User.count", "Ektar::Membership.count"], 1 do
        params = valid_params
        params.delete(:memberships_attributes)
        u = Ektar::User.new(params)
        u.memberships.build(organization: organization)
        u.save
      end
    end

    test "user can tell its organizations" do
      organization = ektar_organizations(:organization)
      admin = ektar_users(:user)

      assert_includes admin.organizations, organization
    end

    test "member_of? method returns wether or not an user belongs to a given organization" do
      org_user = ektar_users(:user)
      non_org_user = ektar_users(:alternate_user)
      organization = ektar_organizations(:organization)

      assert org_user.member_of?(organization)
      refute non_org_user.member_of?(organization)
    end

    test "user can tell which organizations his admin of" do
      organization = ektar_organizations(:organization)
      admin = ektar_users(:admin_user)

      assert_includes admin.admin_of, organization
    end

    test "Organizations of `admin_of` method can be added through memberships" do
      non_admin_user = ektar_users(:user)
      organization = ektar_organizations(:organization)

      refute_includes non_admin_user.admin_of, organization
      refute non_admin_user.admin?

      non_admin_user.memberships.create(organization: organization, role: :admin)
      now_admin_user = non_admin_user

      assert_includes now_admin_user.admin_of, organization
      assert now_admin_user.admin?
    end

    test "admin? method tells if the user is admin of any organization" do
      user_admin = ektar_users(:admin_user)
      user = ektar_users(:user)

      assert user_admin.admin?
      refute user.admin?
    end

    test "admin_of? method tells if the given user is admin of a given organization" do
      user_admin = ektar_users(:admin_user)
      user_no_admin = ektar_users(:user)
      organization = ektar_organizations(:organization)

      assert user_admin.admin_of?(organization)
      refute user_no_admin.admin_of?(organization)
    end

    # test "is invalid without valid encrypted_password" do
    #   subject = User.new valid_params.merge(encrypted_password: "123")

    #   refute subject.valid?
    #   assert_equal 1, subject.errors.count
    # end

    private

    def valid_params
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       memberships_attributes: [organization_attributes: {name: "organization example"}],}
    end

    def invalid_params_organization
      {email: "user@example.example",
       password: "Password14",
       password_confirmation: "Password14",
       ektar_organization_id: Ektar::Organization.last.id + 1,}
    end

    def invalid_params_email
      organization = ektar_organizations(:organization)
      {email: " ",
       password: "Password14",
       password_confirmation: "Password14",
       ektar_organization_id: organization.id,}
    end
  end
end
