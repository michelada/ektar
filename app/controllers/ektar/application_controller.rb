# frozen_string_literal: true

module Ektar
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "ektar/application"

    def collection
      @collection ||= model_name.all
    end

    def resource_new
      @resource ||= model_name.new
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
        set_resource_ivar model
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
      if options.key?(:notice)
        flash[:notice] = options[:notice]
      elsif options.key?(:alert)
        flash[:alert] = options[:alert]
      end
    end
    helper_method :collection, :resource_new, :create_resource, :class_name, :resource_edit, :edit_resource_path, :resource_path, :new_resource_path

    def edit_resource_path(object)
      send route_prefix_to_method_name("edit","#{class_name.model_name.singular_route_key}_path"),
        object
    end

    def resource_path(object)
      if route_prefix.present?
        send "#{route_prefix}_#{class_name.model_name.singular_route_key}_path"
      else
        send "#{class_name.model_name.singular_route_key}_path"
      end
    end

    def new_resource_path
      send route_prefix_to_method_name("new","#{class_name.model_name.singular_route_key}_path")
    end

    def collection_path
      send route_prefix_to_method_name('',"#{class_name.model_name.singular_route_key}_path")
    end

    def route_prefix_to_method_name(method, *path_ivar)
      if route_prefix.present? && !method.blank?
        "#{method}_#{route_prefix}_#{path_ivar[0]}"
      elsif route_prefix.present?
        "#{route_prefix}_#{path_ivar[0]}"
      elsif path_ivar.present? && !method.blank?
        "#{method}_#{path_ivar[0]}"
      else
       path_ivar[0]
      end
    end
  end
end
