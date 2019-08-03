# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Show
    extend ActiveSupport::Concern

    included do
      def show
      end
      alias show! show
    end
  end
end
