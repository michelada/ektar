# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Create
    extend ActiveSupport::Concern

    included do
      def create(options = {}, &block)
        object = get_resource || create_resource
        options[:location] = collection_path if object.errors.empty?

        redirect_with(object, options, &block)
      end
      alias_method :create!, :create
    end
  end
end
