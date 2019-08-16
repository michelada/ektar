# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Destroy
    extend ActiveSupport::Concern

    included do
      def destroy(options = {}, &block)
        object = @resource ||= resource(find: true)
        object.destroy
        options[:location] = collection_path
        options[:action] = :delete

        action_response_dual object, options, &block
      end
      alias_method :destroy!, :destroy
    end
  end
end
