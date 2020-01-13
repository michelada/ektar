# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Show
      extend ActiveSupport::Concern

      included do
        def show(options = {}, &block)
          @resource ||= resource_class.find(params[:id])
          set_resource_ivar @resource

          yield @resource if block_given?
        end

        alias_method :show!, :show
      end
    end
  end
end
