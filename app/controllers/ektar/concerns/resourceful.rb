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

      unless respond_to?(:list_attributes)
        def list_attributes
          resource.attribute_names.map(&:to_sym)
        end
      end

      unless respond_to?(:form_attributes)
        def form_attributes
          Hash[(list_attributes - %i[id updated_at created_at]).map { |attr| [attr, :input] }]
        end
      end

      unless respond_to?(:show_attributes)
        def show_attributes
          resource.attribute_names.map(&:to_sym)
        end
      end

      def new_resource_path
        path = "new_#{resource_class.model_name.singular_route_key}_path"
        send(path)
      end

      def edit_resource_path(resource)
        path = "edit_#{resource.model_name.singular_route_key}_path"
        send(path, resource)
      end

      def resource_path(resource)
        path = "#{resource.model_name.singular_route_key}_path"
        send(path, resource)
      end

      def collection_path
        send "#{resource_class.model_name.route_key}_path"
      end

      def delete_confirmation(resource)
        name = resource.model_name.i18n_key
        t("table.confirmation.#{name}.delete", default: t("table.confirmation.delete"))
      end

      helper_method :link_attribute, :allow_delete?, :new_resource_path, :edit_resource_path,
        :resource_path, :collection_path, :delete_confirmation, :list_attributes, :form_attributes,
        :show_attributes
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
