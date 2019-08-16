# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Edit
    extend ActiveSupport::Concern

    included do
      def edit(options = {}, &block)
        @resource ||= resource(find: true)
        yield @resource if block_given?
      end
      alias_method :edit!, :edit
    end
  end
end
