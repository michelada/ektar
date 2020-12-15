# typed: ignore
require "ektar/engine"
require "activerecord/postgres_enum"
require "money-rails"
require "sorbet-rails"

module Ektar
  class << self
    attr_accessor :configuration

    def webpacker
      @root_path ||= Ektar.configuration.rails_root || Pathname.new(File.join(__dir__, ".."))
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: @root_path,
        config_path: @root_path.join("config", "webpacker.yml")
      )
    end

    def webpacker_dev_server
      Ektar.webpacker.config.dev_server
    rescue
      nil
    end
  end

  class Configuration
    # Host where is running webpacker (Useful while developing)
    # It sets the `:host` attribute of the `javascript_pack_tag` helper.
    attr_accessor :webpacker_host, :title, :organization_username, :organization_password,
      :session_name, :session_expiration, :session_domain, :password_retain_count, :root_app_path, :sign_in_path,
      :sign_out_path, :rails_root, :secret_key

    def initialize
      @title = "Ektar administration"
      @organization_username = "superadmin"
      @organization_password = "superadmin123"
      @session_name = "_ektar"
      @session_expiration = 1.day
      @password_retain_count = 3
      @root_app_path = "/"
      @sign_in_path = nil
      @sign_out_path = "/"
      @rails_root = nil
      @session_domain = nil
      @secret_key = nil
    end
  end

  def self.init_config
    self.configuration ||= Configuration.new
  end

  def self.configure
    init_config
    yield(configuration)
  end
end

Ektar.init_config
