# frozen_string_literal: true

require "active_support/concern"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/show"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/create"
require_dependency "ektar/concerns/edit"
require_dependency "ektar/concerns/update"
require_dependency "ektar/concerns/destroy"

module Ektar
  module Resourceful
    extend ActiveSupport::Concern

    included do
      def link_attribute
        :name
      end

      def allow_delete?(resource)
        true
      end

      helper_method :link_attribute, :allow_delete?
    end

    class_methods do
      def resourceful(model_name, *actions)
        class_attribute :model_name, instance_writer: false
        self.model_name = model_name

        Array(actions).each do |name|
          case name
          when :index then include Index
          when :new then include New
          when :create then include Create
          when :edit then include Edit
          when :update then include Update
          when :show then include Show
          when :destroy then include Destroy
          end
        end
      end
    end
  end
end
