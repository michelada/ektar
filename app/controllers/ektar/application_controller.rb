# typed: false
# frozen_string_literal: true

require "pagy"
require "pagy/extras/bulma"
require "pagy/extras/i18n"

module Ektar
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "ektar/application"

    class ResourceResponse
      def response(&block)
        @block = block
      end

      def code
        @block
      end
    end

    attr_reader :pagination, :resource, :collection

    def resource_ivar
      "@#{resource_class.model_name.singular}"
    end

    def get_resource
      instance_variable_get resource_ivar
    end

    def set_resource_ivar(object)
      instance_variable_set resource_ivar, object
    end

    def action_response_dual(object, options, &block)
      invalid_resource = object&.errors&.any?

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
          render object.persisted? ? :edit : :new
        elsif success.code.present?
          success.code.call
        else
          redirect_to options[:location]
        end

      else
        if invalid_resource
          render object.persisted? ? :edit : :new
        else
          redirect_to options[:location]
        end
      end
    end

    def redirect_with(object, options, &block)
      set_flash options
    end

    def resource_secure_params
      params_method = "#{action_name}_secure_params".to_sym

      filtered_params = (respond_to?(params_method, true) && send(params_method)) ||
        (respond_to?(:secure_params, true) && send(:secure_params))

      filtered_params || params
    end

    def resource_class
      @resource_class ||= if model_name.to_s.include? "_"
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
      result = options[:errors].present? ? :alert : :notice
      default_key = "flash.#{options[:action]}.#{result}"
      resource_key = "flash.#{options[:action]}.#{options[:klass]}.#{result}"

      flash_message = I18n.t(resource_key, default: I18n.t(default_key))
      if result == :alert
        flash.now[result] = flash_message
      else
        flash[result] = flash_message
      end
    end

    def super_admin?
      @super_admin ||= session[:super_admin].present?
    end

    helper_method :action_response_dual, :collection, :resource, :resource_class,
      :super_admin?, :select_options
  end
end
