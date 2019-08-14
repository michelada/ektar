# frozen_string_literal: true

module Ektar
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "ektar/application"

    def collection
      @collection ||= model_name.all
    end

    def build_resource(options = {})
      model_name.new options
    end

    def resource(find: false, options: {})
      @resource ||= if find
        class_name.find(params[:id])
      end
    end

    def resource_edit
      get_resource || find_resource
    end

    def resource_ivar
      "@#{class_name.model_name.singular}"
    end

    def create_resource
      model_name.new(get_secure_params).tap do |model|
        model.save
        @resource = model
      end
    end

    def get_resource
      instance_variable_get resource_ivar
    end

    def set_resource_ivar(object)
      instance_variable_set resource_ivar, object
    end

    def find_resource
      set_resource_ivar class_name.find(params[:id])
    end

    def find_and_update_resource
      model = class_name.find(params[:id])
      model.tap do |m|
        m.update get_secure_params
        set_resource_ivar m
      end
    end

    def collection_path
      send "#{class_name.model_name.route_key}_path"
    end

    def action_response_dual(object, options, &block)
      invalid_resource = @resource&.errors&.any?

      set_flash options.merge(
        klass: class_name.model_name.element,
        errors: invalid_resource
      )

      if invalid_resource
        render :new
      else
        options[:location] = block.call if block_given?
        redirect_to options[:location]
      end
    end

    def redirect_with(object, options, &block)
      args = [object, options]
      set_flash options
    end

    def set_flash(options = {})
      if options.key?(:notice)
        flash[:notice] = options[:notice]
      elsif options.key?(:alert)
        flash[:alert] = options[:alert]
      end
    end

    def get_secure_params
      params_method = "#{action_name}_secure_params".to_sym

      filterd_params =
        (send(params_method) if respond_to?(params_method, true)) ||
        (send(:secure_params) if respond_to?(:secure_params, true))

      unless filterd_params
        raise NotImplementedError,
          "You need to define template methods for strong params"
      end

      filterd_params
    end

    def class_name
      if model_name.to_s.include? "_"
        ns, *klass = model_name.to_s.split("_").collect(&:camelize)
        begin
          "#{ns}::#{klass.join("")}".constantize
        rescue NameError
          "#{ns}#{klass.join("")}".constantize
        end
      else
        model_name.to_s.camelize.constantize
      end
    end

    def set_flash(options = {})
      result = options[:errors] ? :alert : :notice
      default_key = "flash.#{options[:action]}.#{result}"
      resource_key = "flash.#{options[:action]}.#{options[:klass]}.#{result}"

      flash[result] = I18n.t(resource_key, default: I18n.t(default_key))
    end
    helper_method :action_response_dual, :collection, :build_resource, :resource, :create_resource, :respond_with_dual, :class_name, :resource_edit
  end
end
