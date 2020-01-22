# typed: strict

module Ektar
  class ResourcefulController < ApplicationController
    extend T::Sig

    class_attribute :resource_class, instance_writer: false
    class_attribute :list_attributes, instance_writer: false

    sig { params(resource_class: T.untyped, list_attributes: T::Array[Symbol]).void }
    def self.resourceful(resource_class:, list_attributes:)
      self.resource_class = resource_class
      self.list_attributes = list_attributes

      include Ektar::Concerns::Index
    end

    sig { returns(String) }
    def new_resource_path
      path = "new_#{resource_class.model_name.singular_route_key}_path"
      send(path)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def edit_resource_path(resource)
      path = "edit_#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def resource_path(resource)
      path = "#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end

    sig { returns(String) }
    def collection_path
      send "#{resource_class.model_name.route_key}_path"
    end

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_delete?(resource)
      true
    end

    sig { returns(Symbol) }
    def link_attribute
      :name
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def delete_confirmation(resource)
      name = resource.model_name.i18n_key
      T.unsafe(self).t("table.confirmation.#{name}.delete", default: T.unsafe(self).t("table.confirmation.delete"))
    end

    sig { returns(T.untyped) }
    def resource_class
      self.class.resource_class
    end

    sig { returns(T.untyped) }
    def list_attributes
      self.class.list_attributes
    end

    helper_method :resource_class, :new_resource_path, :edit_resource_path, :collection_path, :resource_path,
      :link_attribute, :delete_confirmation, :list_attributes, :allow_delete?
  end
end
