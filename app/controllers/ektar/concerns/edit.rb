# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Edit
    extend ActiveSupport::Concern

    included do
      def edit(options = {}, &block)
        resource_edit 
        yield resource_edit if block_given?
        #respond_with(object, options, &block)
      end
      alias :edit! :edit
    end
  end
end
