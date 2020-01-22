# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Update
      extend ActiveSupport::Concern

      included do
        def update(options = {}, &block)
          @resource ||= resource_class.find_by(find_by_param => params[:id]).tap { |r| r.update(resource_secure_params) }
          set_resource_ivar @resource

          options[:location] = collection_path
          options[:action] = :update

          action_response_dual resource, options, &block
        end
        alias_method :update!, :update
      end
    end
  end
end
