# typed: false
require "webpacker/helper"
require "pagy"

module Ektar
  module ApplicationHelper
    include ::Webpacker::Helper
    include ::Pagy::Frontend

    def current_webpacker_instance
      Ektar.webpacker
    end

    def model_human_name(model, plural: true)
      model.model_name.human(count: plural ? 3 : 1)
    end

    def attribute_value(value)
      case value
      when TrueClass
        t("table.true")
      when FalseClass
        t("table.false")
      when ActiveSupport::TimeWithZone
        l value, format: :short
      when ActionText::RichText
        value.body&.html_safe
      else
        value
      end
    end

    def new_title
      model_name = resource_class.model_name
      t("table.new.#{model_name.i18n_key}",
        default: t("table.new.name", resource_name: model_name.human(count: 1)))
    end

    def edit_title
      model_name = resource_class.model_name
      t("table.edit.#{model_name.i18n_key}",
        default: t("table.edit.name", resource_name: model_name.human(count: 1)))
    end

    def show_title
      model_name = resource_class.model_name
      t("table.show.#{model_name.i18n_key}",
        default: t("table.show.name", resource_name: model_name.human(count: 1)))
    end

    def edit_action
      model_name = resource_class.model_name
      t("table.actions.#{model_name.i18n_key}.edit",
        default: t("table.actions.edit"))
    end

    def delete_action
      model_name = resource_class.model_name
      t("table.actions.#{model_name.i18n_key}.delete",
        default: t("table.actions.delete"))
    end

    def input_attributes(field_name)
      key = resource_class.model_name.i18n_key
      {
        placeholder: t("placeholders.#{key}.#{field_name}", default: ""),
        maxlength: t("maxlength.#{key}.#{field_name}", default: t("maxlength.size")),
      }
    end
  end
end
