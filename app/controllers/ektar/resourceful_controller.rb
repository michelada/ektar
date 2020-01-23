# typed: strict

module Ektar
  class ResourcefulController < ApplicationController
    extend T::Sig

    VALID_RESOURCE_ACTIONS = T.let({index: Ektar::Concerns::Index,
                                    new: Ektar::Concerns::New,
                                    create: Ektar::Concerns::Create,
                                    edit: Ektar::Concerns::Edit,
                                    update: Ektar::Concerns::Update,
                                    show: Ektar::Concerns::Show,
                                    destroy: Ektar::Concerns::Destroy,},
      T::Hash[Symbol, Module])

    class_attribute :resource_class, instance_writer: false
    class_attribute :list_attributes, instance_writer: false
    class_attribute :form_attributes, instance_writer: false
    class_attribute :show_attributes, instance_writer: false
    class_attribute :find_by, instance_writer: false

    sig do
      params(list_attributes: T::Array[Symbol],
             form_attributes: T::Hash[Symbol, Symbol],
             show_attributes: T::Array[Symbol],
             resource_class: T.untyped,
             only: T.untyped,
             except: T.nilable(T.any(T::Array[Symbol], Symbol)),
             find_by: Symbol).void
    end
    def self.resourceful(list_attributes:, form_attributes:, show_attributes:, resource_class: nil, only: nil, except: nil, find_by: :id)
      self.list_attributes = list_attributes
      self.form_attributes = form_attributes
      self.show_attributes = show_attributes
      self.resource_class = resource_class || controller_path.classify.constantize
      self.find_by = find_by

      only_actions = [only].compact
      except_actions = [except].compact

      actions_keys = VALID_RESOURCE_ACTIONS.keys

      actions = if only_actions.any?
        actions_keys & only_actions
      elsif except_actions.any?
        actions_keys - except_actions
      else
        actions_keys.dup
      end

      Array(actions).each do |name|
        if actions_keys.include?(name)
          include T.must(VALID_RESOURCE_ACTIONS[name])
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

    sig { returns(Symbol) }
    def find_by_param
      self.class.find_by || :id
    end

    helper_method :resource_class, :new_resource_path, :edit_resource_path, :collection_path, :resource_path,
      :link_attribute, :delete_confirmation, :list_attributes, :form_attributes, :show_attributes, :allow_delete?
  end
end
