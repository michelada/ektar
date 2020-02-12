# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Create
      extend ActiveSupport::Concern

      included do
        def create(options = {}, &block)
          @resource ||= begin
            resource = resource_class.new(resource_secure_params)

            authorize resource, policy_class: policy_class if policy_class.present?
            resource.save

            resource
          end

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
