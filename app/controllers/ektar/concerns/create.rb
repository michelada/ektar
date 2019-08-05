# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Create
    extend ActiveSupport::Concern

    included do
      def create(options = {}, &block)
        object = get_resource || create_resource

        byebug
        options[:location] = collection_path if object.errors.empty?

        respond_with_dual(object, options, &block)
      end
      alias create! create
    end
  end
end
