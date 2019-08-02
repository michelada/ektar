require "active_support/concern"

module Ektar
  module New
    extend ActiveSupport::Concern

    included do
      def new(options = {}, &block)
        resource
        yield resource if block_given?
      end
      alias_method :new!, :new
    end
  end
end
