# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Create
    extend ActiveSupport::Concern

    included do
      def create(options = {}, &block)
        @resource ||= create_resource
        set_resource_ivar @resource

        options[:location] = collection_path
        options[:action] = :create

        action_response_dual resource, options, &block
      end
      alias_method :create!, :create
    end
  end
end
