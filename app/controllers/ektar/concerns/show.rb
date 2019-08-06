# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Show
    extend ActiveSupport::Concern

    included do
      def show(options = {}, &block)
        object = get_resource || find_resource
      end
  
      alias show! show
    end
  end
end
