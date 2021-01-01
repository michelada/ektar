# typed: ignore
require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)
require "ektar"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.available_locales = :es
    config.i18n.default_locale = :es

    if Rails.env.development?
      config.web_console.development_only = false
      config.action_mailer.preview_path = Rails.root.to_s.gsub("/dummy", "/mailers/previews") if Rails.env.development?
    end
  end
end
