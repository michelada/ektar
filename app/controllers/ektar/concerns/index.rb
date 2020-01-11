# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Index
    extend ActiveSupport::Concern

    included do
      include Pagy::Backend

      def index(options = {}, &block)
        @collection ||= begin
                          scope = resource_class.order(updated_at: :desc)
                          scope = scope.search_full(params[:q]) if params[:q].present? && resource_class.respond_to?(:search_full)

                          @pagination, collection = pagy(scope, i18n_key: "activerecord.models.#{resource_class.model_name.i18n_key}")
                          collection
                        end
      end
      alias_method :index!, :index
    end
  end
end
