require "webpacker/helper"

module Ektar
  module ApplicationHelper
    include ::Webpacker::Helper
    include Pagy::Frontend

    def current_webpacker_instance
      Ektar.webpacker
    end

    def select_options(attribute_name)
      options = []
      attributes_options.each do |attribute|
        if attribute.keys[0] == attribute_name
          attribute.values[0].split(",") do |option|
            options += [t("forms.dropdown_options", option: option)]
          end
        end
      end
      options
    end

    def model_human_name(model, plural: true)
      model_class = case model
                    when :organization then Ektar::Organization
                    else model
      end

      return model_class.model_name.human(count: plural ? 2 : 1) if model_class.present?
      model
    end

    def attribute_value(value)
      case value
      when TrueClass
        t("table.true")
      when FalseClass
        t("table.false")
      when ActiveSupport::TimeWithZone
        l value, format: :short
      else
        value
      end
    end

    def resource_edit_path(resource)
      path = "edit_#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end

    def resource_show_path(resource)
      path = "#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end
  end
end
