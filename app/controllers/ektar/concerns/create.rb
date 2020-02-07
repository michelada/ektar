# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Create
      extend ActiveSupport::Concern

      included do
        def create(options = {}, before_save: nil, &block)
          @resource ||= resource_class.new(resource_secure_params)

          before_save&.call(@resource)

          @resource.save
          set_resource_ivar @resource

          options[:location] = collection_path
          options[:action] = :create

          action_response_dual resource, options, &block
        end
        alias_method :create!, :create
      end
    end
  end
end
