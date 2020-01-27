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

    test "is valid" do
      subject = User.new valid_params

      assert subject.valid?
    end

    test "is invalid" do
      subject = User.new invalid_params_email

      refute subject.valid?
      assert_equal 3, subject.errors.count
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

    # test "is invalid without valid encrypted_password" do
    #   subject = User.new valid_params.merge(encrypted_password: "123")

    #   refute subject.valid?
    #   assert_equal 1, subject.errors.count
    # end

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
