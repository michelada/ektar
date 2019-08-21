# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Update
    extend ActiveSupport::Concern

    included do
      def update(options = {}, &block)
        object = get_resource ||= find_and_update_resource

        options[:location] = collection_path if object.errors.empty?
        options[:action] = :update

        action_response_dual object, options, &block
      end
      alias_method :update!, :update
    end
  end
end
