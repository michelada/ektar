require "ektar/engine"

module Ektar
  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

  class << self
    attr_accessor :configuration

    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join("config", "webpacker.yml")
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
    attr_accessor :webpacker_host
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
