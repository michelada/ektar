# typed: false
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Index
      extend ActiveSupport::Concern

      included do
        include Pagy::Backend

        def index(options = {}, &block)
          @collection ||= begin
                            scope = resource_class.order(updated_at: :desc)
                            scope = scope.search_full(params[:q]) if params[:q].present? && resource_class.respond_to?(:search_full)

                            authorize scope, policy_class: policy_class if policy_class.present?

                            scope = yield(scope) if block_given?

                            @pagination, collection = pagy(scope, i18n_key: "activerecord.models.#{resource_class.model_name.i18n_key}")
                            collection
                          end

          respond_to do |format|
            format.html
            format.json { render json: @collection }
          end
        end
        alias_method :index!, :index
      end
    end
  end
end
