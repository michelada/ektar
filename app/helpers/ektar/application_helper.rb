# typed: false
require "webpacker/helper"
require "pagy"

module Ektar
  module ApplicationHelper
    include ::Webpacker::Helper
    include ::Pagy::Frontend
    extend T::Sig
    include Kernel

    sig { returns(Webpacker::Instance) }
    def current_webpacker_instance
      Ektar.webpacker
    end

    sig { params(model: T.class_of(ActiveRecord::Base), plural: T.nilable(T::Boolean)).returns(String) }
    def model_human_name(model, plural: true)
      model.model_name.human(count: plural ? 3 : 1)
    end

    sig { params(value: BasicObject).returns(T.any(BasicObject, String)) }
    def attribute_value(value)
      case value
      when TrueClass
        I18n.t("table.true")
      when FalseClass
        I18n.t("table.false")
      when ActiveSupport::TimeWithZone
        I18n.l value, format: :short
      when ActionText::RichText
        value.body&.html_safe
      when Money
        "#{number_to_currency(value.fractional, unit: value.currency.symbol,
                                                format: "%u%n",
                                                separator: ".",
                                                delimiter: ",")}
                                                #{value.currency.iso_code} "
      else
        value
      end
    end

    sig { returns(String) }
    def new_title
      model_name = resource_class.model_name
      I18n.t("table.new.#{model_name.i18n_key}",
        default: I18n.t("table.new.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def edit_title
      model_name = resource_class.model_name
      I18n.t("table.edit.#{model_name.i18n_key}",
        default: I18n.t("table.edit.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def show_title
      model_name = resource_class.model_name
      I18n.t("table.show.#{model_name.i18n_key}",
        default: I18n.t("table.show.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def edit_action
      model_name = resource_class.model_name
      I18n.t("table.actions.#{model_name.i18n_key}.edit",
        default: I18n.t("table.actions.edit"))
    end

    sig { returns(String) }
    def delete_action
      model_name = resource_class.model_name
      I18n.t("table.actions.#{model_name.i18n_key}.delete",
        default: I18n.t("table.actions.delete"))
    end

    sig { params(field_name: T.any(Symbol, String)).returns(T::Hash[Symbol, T.untyped]) }
    def input_attributes(field_name)
      key = resource_class.model_name.i18n_key
      {
        class: "input",
        placeholder: t("placeholders.#{key}.#{field_name}", default: ""),
        maxlength: t("maxlength.#{key}.#{field_name}", default: t("maxlength.size")),
      }
    end
  end
end
