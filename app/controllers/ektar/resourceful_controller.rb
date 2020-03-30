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
                                    destroy: Ektar::Concerns::Destroy},
      T::Hash[Symbol, Module])

    class_attribute :resource_class, instance_writer: false
    class_attribute :list_attributes, instance_writer: false
    class_attribute :form_attributes, instance_writer: false
    class_attribute :show_attributes, instance_writer: false
    class_attribute :find_by, instance_writer: false
    class_attribute :policy_class, instance_writer: false
    class_attribute :namespace, instance_writer: false

    # +resourceful+ method helps you define the actions that will be included on your controller. It also lets you
    # specify the attributes that must be shown in some views, such as +show+, +index+, +new+ and +edit+
    #
    # == Parameters
    #
    # [resource_class]
    #   Specifies the name of the model associated with the controller implementing +resourceful+.
    #   If no specified, the +resource_name+ can be infered from the controller name.
    #   i.e: A controller named `UsersController` implementing resourceful, will assume its resource_class is user.
    #   Also supports namespaces
    #
    # [list_attributes]
    #   Must be an array of symbols, representing each of the attributes that want to be displayed in the +index+ view
    #   i.e: +list_attributes: %i[name description updated_at] +
    #
    # [show_attributes]
    #   Same as +list_attributes+, but works for +show+ view.
    #
    # [form_attributes]
    #   It's a hash containing a group of keys for each resource attribute, and the values representing the type of
    #   element corresponding to that attribute.
    #
    #   Supported values:
    #     [type]
    #       The type of the attribute. If this is the only option that will be specified for the +resourceful+ method,
    #       you can send this as the only value for the key, so that
    #         +form_attributes: {name: {type: :input}} +
    #       can be written simply as
    #         +form_attributes: {name: :input}
    #
    #       Supported types are:
    #         - checkbox
    #         - currency
    #         - currencyfile
    #         - image
    #         - input
    #         - number
    #         - password
    #         - radio
    #         - rich_text
    #         - select
    #         - text_area
    #
    #     [input_html]
    #       A hash containing the options that will be merged to the input attributes.
    #         The following code add two classes to our input:
    #         +form_attributes: {name: {type: :input, input_html: {class: "input is-success"}}}+
    #
    #     [control_html]
    #       The html options for a +div+ container that will wrap the form field for that attribute
    #         +form_attributes: {name: {type: :input, control_html: {data-controller: "form_controller"}}}+
    #
    #         This will create:
    #           <div data-controller: "form_controller">
    #             <!-- Our input html -->
    #             ...
    #           </div>
    #
    #     [options]
    #       An array of symbols including the options for a group of radio buttons or a select input
    #         +form_attributes: {name: {country: :radio, input_html: {class: "radio"}, options: %i[Mexico USA Canada]}}+
    #
    # [only]
    #   Similar to rails, it only includes the options specified in the array of symbols.
    #     +resourceful only: [:new, :create, :index]+
    #
    # [except]
    #   Includes all the RESTful action modules, except those specified in this parameter.
    #     +resourceful except: [:show, :destroy, :edit, :update]+
    #
    # [find_by]
    #   This parameter specifies the index used for the model table, defaults to +id+
    #
    sig do
      params(
        list_attributes: T.nilable(T::Array[Symbol]),
        form_attributes: T.nilable(T::Hash[Symbol, T.untyped]),
        show_attributes: T.nilable(T::Array[Symbol]),
        resource_class: T.untyped,
        only: T.nilable(T.any(T::Array[Symbol], Symbol)),
        except: T.nilable(T.any(T::Array[Symbol], Symbol)),
        find_by: Symbol,
        policy_class: T.nilable(Class),
        namespace: T.nilable(Module)
      ).void
    end
    def self.resourceful(list_attributes: nil, form_attributes: nil, show_attributes: nil, resource_class: nil, only: nil, except: nil, find_by: :id, policy_class: nil, namespace: nil)
      self.list_attributes = list_attributes
      self.form_attributes = form_attributes
      self.show_attributes = show_attributes
      self.resource_class = resource_class || controller_path.classify.constantize
      self.find_by = find_by
      self.policy_class = policy_class
      self.namespace = namespace

      only_actions = Array(only).compact
      except_actions = Array(except).compact

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
      namespace_path = namespace.blank? ? "" : "#{namespace}_"
      path = "new_#{namespace_path}#{resource_class.model_name.singular_route_key}_path"
      Rails.application.routes.url_helpers.send(path)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def edit_resource_path(resource)
      namespace_path = namespace.blank? ? "" : "#{namespace}_"
      path = "edit_#{namespace_path}#{resource.model_name.singular_route_key}_path"
      Rails.application.routes.url_helpers.send(path, resource)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def resource_path(resource)
      namespace_path = namespace.blank? ? "" : "#{namespace}_"
      path = "#{namespace_path}#{resource.model_name.singular_route_key}_path"
      Rails.application.routes.url_helpers.send(path, resource)
    end

    sig { returns(String) }
    def collection_path
      namespace_path = namespace.blank? ? "" : "#{namespace}_"
      path = "#{namespace_path}#{resource_class.model_name.route_key}_path"
      Rails.application.routes.url_helpers.send(path)
    end

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_delete?(resource)
      true
    end

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_edit?(resource)
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
      self.class.list_attributes ||= resource_class.attribute_names.map(&:to_sym)
    end

    sig { returns T.nilable(T::Hash[Symbol, T.untyped]) }
    def form_attributes
      self.class.form_attributes ||= Hash[(T.must(list_attributes) - %i[id updated_at created_at]).map { |attr| [attr, :input] }]
    end

    sig { returns T.nilable(T::Array[Symbol]) }
    def show_attributes
      self.class.show_attributes ||= list_attributes
    end

    sig { returns(Symbol) }
    def find_by_param
      self.class.find_by || :id
    end

    sig { returns(String) }
    def resource_ivar
      "@#{resource_class.model_name.singular}"
    end

    sig { params(object: BasicObject).returns(Object) }
    def set_resource_ivar(object)
      instance_variable_set resource_ivar, object
    end

    sig { returns(Object) }
    def resource
      @resource = T.let(@resource, T.nilable(Object))
    end

    sig { returns(T.nilable(String)) }
    def namespace
      @namespace = T.let(@namespace, T.nilable(String))
      @namespace ||= begin
                       self.class.namespace&.to_s&.underscore&.gsub("/", "_")
                     end
    end

    sig { params(object: ActiveRecord::Base, options: T.nilable(T.untyped), block: T.nilable(T.untyped)).returns(T.untyped) }
    def action_response_dual(object, options, &block)
      invalid_resource = T.unsafe(object)&.errors&.any?

      set_flash options.merge(
        klass: resource_class.model_name.element,
        errors: invalid_resource
      )

      case block.try(:arity)
      when 2
        success = ResourceResponse.new
        failure = ResourceResponse.new
        block.call success, failure

        if invalid_resource
          failure.code.call
        else
          success.code.call
        end

      when 1
        success = ResourceResponse.new
        block.call success

        if invalid_resource
          respond_to do |format|
            format.json { render json: {errors: object.errors, flash: flash.alert || flash.alert.now, localtion: options[:location]}, status: :unprocessable_entity }
            format.html { render object.persisted? ? :edit : :new }
          end
        elsif success.code.present?
          success.code.call
        else
          respond_to do |format|
            format.html { redirect_to options[:location] }
            format.json { render json: object.errors, status: :unprocessable_entity }
          end
        end

      else
        if invalid_resource
          respond_to do |format|
            format.json { render json: {errors: object.errors, flash: flash.alert || flash.alert.now, localtion: options[:location]}, status: :unprocessable_entity } unless options[:action] == :destroy
            format.json { head :no_content } if options[:action] == :destroy
            format.html { render object.persisted? ? :edit : :new }
          end
        else
          respond_to do |format|
            format.html { redirect_to options[:location] }
            format.json { render json: object }
          end
        end
      end
    end

    helper_method :namespace, :resource_class, :new_resource_path, :edit_resource_path, :collection_path, :resource_path,
      :link_attribute, :delete_confirmation, :list_attributes, :form_attributes, :show_attributes, :allow_delete?, :allow_edit?, :set_resource_ivar
  end
end
