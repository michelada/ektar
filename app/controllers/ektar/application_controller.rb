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

    def get_resource
      instance_variable_get resource_ivar
    end

    def set_resource_ivar(object)
      instance_variable_set resource_ivar, object
    end

    def create_resource
      model_name.new(get_secure_params).tap do |model|
        model.save
        set_resource_ivar model
      end
    end

    def collection_path
      send "#{class_name.model_name.route_key}_path"
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

    def respond_with_dual(object, options, &block)
      args = [object, options]
      set_flash options

      case block.try(:arity)
      # when 2
      #   respond_with(*args) do |responder|
      #     dummy_responder = Restful::DummyResponder.new

      #     if get_resource_ivar.errors.empty?
      #       block.call responder, dummy_responder
      #     else
      #       block.call dummy_responder, responder
      #     end
      #   end
      when 1
        respond_with(*args, &block)
      else
        options[:location] = block.call if block
        respond_with(*args)
      end
    end

    def set_flash(options = {})
      if options.key?(:notice)
        flash[:notice] = options[:notice]
      elsif options.key?(:alert)
        flash[:alert] = options[:alert]
      end
    end

    # def update_resource(object, attributes)
    #   object.update(*attributes)
    # end

    # def destroy_resource(object)
    #   object.destroy
    # end
    helper_method :collection, :resource, :create_resource, :respond_with_dual
  end
end
