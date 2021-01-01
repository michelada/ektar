# typed: ignore

require "test_helper"

module Ektar
  class MembershipTest < ActiveSupport::TestCase
    test "membership role is member by default improved" do
      membership = ektar_memberships(:alternate_membership)

      assert_equal membership.role, "member"
    end

    test "membership is active by default" do
      membership = ektar_memberships(:user_membership)

      assert membership.active?
    end

    test "membership can be deactivated" do
      membership = ektar_memberships(:user_membership)

      assert membership.active?

      membership.active = false

      refute membership.active?
    end
  end
end
