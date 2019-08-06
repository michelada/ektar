# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Edit
    extend ActiveSupport::Concern

    included do
      def edit(options = {}, &block)
        object = get_resource || find_resource
        yield object if block_given?
      end
      alias :edit! :edit
    end
  end
end
