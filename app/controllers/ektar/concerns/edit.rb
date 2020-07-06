# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Edit
      extend ActiveSupport::Concern

      included do
        def edit(options = {}, &block)
          @resource ||= resource_class.find_by(find_by_param => params[:id])
          set_resource_ivar @resource

          authorize current_organization, policy_class: policy_class if policy_class.present?

          yield @resource if block_given?
        end
        alias_method :edit!, :edit
      end
    end
  end
end
