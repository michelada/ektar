# typed: ignore
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module New
      extend ActiveSupport::Concern

      included do
        def new(options = {}, &block)
          @resource ||= resource_class.new
          set_resource_ivar @resource

          yield @resource if block_given?

          authorize current_organization, policy_class: policy_class if policy_class.present?
        end
        alias_method :new!, :new
      end
    end
  end
end
