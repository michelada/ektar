# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Index
    extend ActiveSupport::Concern

    included do
      def index(options = {}, &block)
        collection
      end
      alias_method :index!, :index
    end
  end
end
