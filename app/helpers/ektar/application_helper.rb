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
      model.model_name.human(count: plural ? 2 : 1)
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

    def input_attributes(field_name)
      key = resource_class.model_name.i18n_key
      {
        placeholder: t("placeholders.#{key}.#{field_name}", default: ""),
        maxlength: t("maxlength.#{key}.#{field_name}", default: t("maxlength.size")),
      }
    end

    def new_resource_path
      path = "new_#{resource_class.model_name.singular_route_key}_path"
      send(path)
    end

    def edit_resource_path(resource)
      path = "edit_#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end

    def resource_path(resource)
      path = "#{resource.model_name.singular_route_key}_path"
      send(path, resource)
    end

    def delete_confirmation(resource)
      name = resource.model_name.i18n_key
      t("table.confirmation.#{name}.delete", default: t("table.confirmation.delete"))
    end
  end
end
