require "webpacker/helper"

module Ektar
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Ektar.webpacker
    end
  end
end
