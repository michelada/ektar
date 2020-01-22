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

    helper_method :resource_class, :new_resource_path, :edit_resource_path, :collection_path, :resource_path,
      :list_attributes
  end
end
