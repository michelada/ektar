# typed: ignore
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Show
      extend ActiveSupport::Concern

      included do
        def show(options = {}, &block)
          @resource ||= resource_class.find_by!(find_by_param => params[:id])
          set_resource_ivar @resource

          authorize current_organization, policy_class: policy_class if policy_class.present?

          yield @resource if block_given?
          respond_to do |format|
            format.html
            format.json { render json: @resource }
          end
        end

        alias_method :show!, :show
      end
    end
  end
end
