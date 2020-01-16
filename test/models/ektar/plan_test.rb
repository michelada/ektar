require "test_helper"

module Ektar
  class PlanTest < ActiveSupport::TestCase
    test "plan has default values" do
      subject = ektar_plans(:plan)

      refute subject.free?
      assert_equal subject.trial, 0
      assert_equal subject.price, 0
      assert subject.active?
    end
  end
end
