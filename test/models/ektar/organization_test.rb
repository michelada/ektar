require "test_helper"

module Ektar
  class OrganizationTest < ActiveSupport::TestCase
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
      organization = ektar_organizations(:main_organization)
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
