# typed: false

require "test_helper"

module Ektar
  class MembershipTest < ActiveSupport::TestCase
    test "membership role is member by default improved" do
      membership = ektar_memberships(:membership)

      assert_equal membership.role, "member"
    end
  end
end
