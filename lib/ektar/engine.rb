# typed: ignore
module Ektar
  class Engine < ::Rails::Engine
    engine_name "ektar"
    isolate_namespace Ektar

    # Configures Webpacker within the host app
    initializer "webpacker.proxy" do |app|
      next unless Ektar.webpacker_dev_server.present?

      app.middleware.insert_before(
        0,
        Webpacker::DevServerProxy, # "Webpacker::DevServerProxy" if Rails version < 5
        ssl_verify_none: true,
        webpacker: Ektar.webpacker
      )
    end

    # Serves the engine's webpack when requested
    initializer "webpacker.static" do |app|
      public_path = File.expand_path(File.join(__dir__, "..", "..", "public"))
      puts public_path
      app.config.middleware.use(
        Rack::Static,
        urls: ["/ektar-packs"],
        root: public_path
      )
    end
  end
end
