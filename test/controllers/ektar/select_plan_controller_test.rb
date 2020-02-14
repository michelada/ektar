# typed: ignore
require "test_helper"

module Ektar
  class SessionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include LoginHelper

    test "it works" do
      assert true
    end
  end
end
