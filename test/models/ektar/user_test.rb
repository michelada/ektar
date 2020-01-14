# typed: false
require "test_helper"

module Ektar
  class UserTest < ActiveSupport::TestCase
    test "it can belong to more than one organization" do
      subject = ektar_users(:user)
      alternate_organization = ektar_organizations(:alternate_organization)

      assert_difference "subject.ektar_organizations.reload.size", 1 do
        subject.ektar_organizations << alternate_organization
        subject.save
      end
    end

    test "to_param uses global_id" do
      subject = ektar_users(:user)

      refute_equal subject.to_param, subject.id
    end

    # test "is valid" do
    #   subject = User.new valid_params

    #   assert subject.valid?
    # end

    # test "is invalid" do
    #   subject = User.new invalid_params_email

    #   refute subject.valid?
    #   assert_equal 2, subject.errors.count
    # end

    # test "is invalid without unique email" do
    #   user = ektar_users(:first_user)
    #   subject = User.new valid_params.merge(email: user.email)

    #   refute subject.valid?
    #   assert_equal 1, subject.errors.count
    # end

    # test "is invalid without valid organization" do
    #   subject = User.new invalid_params_organization
    #   refute subject.valid?

    #   assert_equal 1, subject.errors.count
    # end

    # test "is invalid without valid encrypted_password" do
    #   subject = User.new valid_params.merge(encrypted_password: "123")

    #   refute subject.valid?
    #   assert_equal 1, subject.errors.count
    # end

    # def valid_params
    #   organization = ektar_organizations(:main_organization)
    #   {email: "mario@gmail.com",
    #    encrypted_password: "Password14",
    #    ektar_organization_id: organization.id,}
    # end

    # def invalid_params_organization
    #   {email: "user@example.example",
    #    encrypted_password: "Password14",
    #    ektar_organization_id: Ektar::Organization.last.id + 1,}
    # end

    # def invalid_params_email
    #   organization = ektar_organizations(:main_organization)
    #   {email: " ",
    #    encrypted_password: "Password14",
    #    ektar_organization_id: organization.id,}
    # end
  end
end
