# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Index
    extend ActiveSupport::Concern

    included do
      include Pagy::Backend

      def index(options = {}, &block)
        @collection ||= begin
                          @pagination, collection = pagy(resource_class.order(updated_at: :desc))
                          collection
                        end
      end
      alias_method :index!, :index
    end
  end
end
