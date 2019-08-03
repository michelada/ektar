# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Edit
    extend ActiveSupport::Concern

    included do
      def edit
      end
      alias edit! edit
    end
  end
end
