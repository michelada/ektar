# typed: ignore
# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Filter out the backtrace from minitest while preserving the one from other libraries.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

class ActionDispatch::IntegrationTest
  COOKIE_NAME = "_dummy_remember_me"

  def sign_in(user)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.encrypted[COOKIE_NAME] = {
      value: {
        user: user.global_id,
        organization: user.memberships.first&.organization&.global_id,
      },
      expires: 1.day.from_now,
    }
    cookies[COOKIE_NAME] = my_cookies[COOKIE_NAME]
  end
end
