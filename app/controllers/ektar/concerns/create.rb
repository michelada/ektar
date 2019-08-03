# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Create
    extend ActiveSupport::Concern

    included do
      def create
      end
      alias create! create
    end
  end
end
