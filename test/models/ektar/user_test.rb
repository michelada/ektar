# typed: false
require "test_helper"

module Ektar
  class UserTest < ActiveSupport::TestCase
    test "is valid" do
      subject = User.new user_params

      assert subject.valid?
      assert_equal 1, subject.memberships.size
    end

    test "is invalid" do
      subject = User.new user_params(email: nil, password: nil)

      refute subject.valid?
      refute_nil subject.errors[:email]
      refute_nil subject.errors[:password]
    end

    test "is invalid when email is not unique" do
      existing_user = ektar_users(:user)
      subject = User.new user_params(email: existing_user.email)

      refute subject.valid?
      refute_nil subject.errors[:email]
    end

    test "is invalid when password fails complexity check" do
      subject = User.new user_params(password: "simple-password")

      refute subject.valid?
      refute_nil subject.errors[:password]
    end

    test "new user is invalid with empty organization" do
      subject = User.new user_params(memberships_attributes: [organization_attributes: {}])

      refute subject.valid?
      refute_nil subject.errors[:memberships]
    end

    test "global_id is to_param" do
      subject = ektar_users(:user)

      assert_equal subject.to_param, subject.global_id
    end

    test "user cannot reuse password" do
      subject = ektar_users(:user)
      subject.password = "Password18"

      refute subject.valid?
      refute_nil subject.errors[:password]
    end

    test "user's password digest is store after password change" do
      used_passwords_count = 1
      subject = ektar_users(:user)

      assert_equal used_passwords_count, subject.used_passwords.count

      subject.password = "Password19"
      subject.save
      used_passwords_count += 1

      assert_equal used_passwords_count, subject.used_passwords.count

      subject.password = "Password20"
      subject.save
      used_passwords_count += 1

      assert_equal used_passwords_count, subject.used_passwords.count

      subject.password = "Password21"
      subject.save

      assert_equal 3, subject.used_passwords.count
    end

    test "user can tell its organizations" do
      organization = ektar_organizations(:organization_no_plan)
      admin = ektar_users(:user)

      assert_includes admin.organizations, organization
    end

    test "member?(resource) method returns wether or not an user belongs to a given organization" do
      org_user = ektar_users(:user)
      non_org_user = ektar_users(:regular_user)
      organization = ektar_organizations(:organization_no_plan)

      assert org_user.is_member?(organization)
      refute non_org_user.is_member?(organization)
    end

    test "user can tell which organizations his admin of" do
      organization = ektar_organizations(:organization)
      admin = ektar_users(:admin_user)

      assert_includes admin.admin_of, organization
    end

    test "Organizations of `admin_of` method can be added through memberships" do
      non_admin_user = ektar_users(:regular_user)
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
      user = ektar_users(:regular_user)

      assert user_admin.admin?
      refute user.admin?
    end

    test "is_admin?(resource) method tells if the given user is admin of a given organization" do
      user_admin = ektar_users(:admin_user)
      user_no_admin = ektar_users(:user)
      organization = ektar_organizations(:organization)

      assert user_admin.is_admin?(organization)
      refute user_no_admin.is_admin?(organization)
    end

    private

    def user_params(attrs = {})
      {email: "mario@gmail.com",
       password: "Password17",
       password_confirmation: "Password17",
       memberships_attributes: [organization_attributes: {name: "organization example"}],}.merge(attrs)
    end
  end
end
