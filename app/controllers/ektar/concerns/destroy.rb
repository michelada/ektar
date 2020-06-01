# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Destroy
      extend ActiveSupport::Concern

      included do
        def destroy(options = {}, &block)
          object = resource_class.find_by(find_by_param => params[:id])

          authorize current_organization, policy_class: policy_class if policy_class.present?

          object.destroy
          options[:location] = collection_path
          options[:action] = :destroy

          action_response_dual object, options, &block
        end
        alias_method :destroy!, :destroy
      end
    end
  end
end
