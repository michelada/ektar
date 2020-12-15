# typed: ignore
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Update
      extend ActiveSupport::Concern

      included do
        def update(options = {}, &block)
          @resource ||= begin
            local_resource = resource_class.find_by(find_by_param => params[:id])

            authorize current_organization, policy_class: policy_class if policy_class.present?

            local_resource.update(resource_secure_params)
            set_resource_ivar local_resource
            local_resource
          end

          options[:location] = collection_path
          options[:action] = :update

          action_response_dual resource, options, &block
        end
        alias_method :update!, :update
      end
    end
  end
end
