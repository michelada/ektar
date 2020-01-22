# typed: strict

module Ektar
  class ResourcefulController < ApplicationController
    extend T::Sig

    VALID_RESOURCE_ACTIONS = T.let([:index, :new, :create, :edit, :update, :show, :destroy], T::Array[Symbol])

    class_attribute :resource_class, instance_writer: false
    class_attribute :list_attributes, instance_writer: false
    class_attribute :form_attributes, instance_writer: false
    class_attribute :show_attributes, instance_writer: false

    sig do
      params(resource_class: T.untyped,
             list_attributes: T::Array[Symbol],
             form_attributes: T::Hash[Symbol, Symbol],
             show_attributes: T::Array[Symbol],
             only: T.nilable(T.any(T::Array[Symbol], Symbol)),
             except: T.nilable(T.any(T::Array[Symbol], Symbol))).void
    end
    def self.resourceful(resource_class:, list_attributes:, form_attributes:, show_attributes:, only: nil, except: nil)
      self.resource_class = resource_class
      self.list_attributes = list_attributes
      self.form_attributes = form_attributes
      self.show_attributes = show_attributes

      only = [] if only.nil?
      except = [] if except.nil?

      only = [only] if only.is_a?(Symbol)
      except = [except] if except.is_a?(Symbol)

      actions = if only.any?
        VALID_RESOURCE_ACTIONS & only
      elsif except.any?
        VALID_RESOURCE_ACTIONS - except
      else
        VALID_RESOURCE_ACTIONS.dup
      end

      Array(actions).each do |name|
        if VALID_RESOURCE_ACTIONS.include?(name)
          T.unsafe(self).include "Ektar::Concerns::#{name.capitalize}".constantize
        end
      end
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

    sig { returns T.nilable(T::Array[Symbol]) }
    def list_attributes
      self.class.list_attributes || resource.attribute_names.map(&:to_sym)
    end

    sig { returns T.nilable(T::Hash[Symbol, Symbol]) }
    def form_attributes
      self.class.form_attributes || Hash[(T.must(list_attributes) - %i[id updated_at created_at]).map { |attr| [attr, :input] }]
    end

    sig { returns T.nilable(T::Array[Symbol]) }
    def show_attributes
      self.class.show_attributes || list_attributes
    end

    helper_method :resource_class, :new_resource_path, :edit_resource_path, :collection_path, :resource_path,
      :link_attribute, :delete_confirmation, :list_attributes, :form_attributes, :show_attributes, :allow_delete?
  end
end
