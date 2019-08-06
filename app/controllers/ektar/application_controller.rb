# frozen_string_literal: true

module Ektar
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'ektar/application'

    def collection
      @collection ||= model_name.all
    end

    def resource
      @resource ||= model_name.new
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
      byebug
      set_resource_ivar class_name.find(params[:id])
    end

    def collection_path
      send "#{class_name.model_name.route_key}_path"
    end

    def redirect_with(object, options, &block)
      redirect_to options[:location]
      set_flash options
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
    helper_method :collection, :resource, :create_resource, :respond_with_dual
  end
end
