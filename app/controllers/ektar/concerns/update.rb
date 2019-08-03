# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Update
    extend ActiveSupport::Concern

    included do
      def update(options = {}, &block)
      end
      alias update! update
    end
  end
end
