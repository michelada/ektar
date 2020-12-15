# typed: ignore
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
        I18n.t("yes_value")
      when FalseClass
        I18n.t("no_value")
      when ActiveSupport::TimeWithZone, Date
        I18n.l value, format: :short
      when ActionText::RichText
        value.to_plain_text.truncate_words(40)
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
      I18n.t("index.new.#{model_name.i18n_key}",
             default: I18n.t("index.new.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def edit_title
      model_name = resource_class.model_name
      I18n.t("edit.#{model_name.i18n_key}",
             default: I18n.t("edit.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def show_title
      model_name = resource_class.model_name
      I18n.t("show.#{model_name.i18n_key}",
             default: I18n.t("show.name", resource_name: model_name.human(count: 1)))
    end

    sig { returns(String) }
    def edit_action
      model_name = resource_class.model_name
      I18n.t("index.actions.#{model_name.i18n_key}.edit",
             default: I18n.t("index.actions.edit"))
    end

    sig { returns(String) }
    def delete_action
      model_name = resource_class.model_name
      I18n.t("index.actions.#{model_name.i18n_key}.delete",
             default: I18n.t("index.actions.delete"))
    end

    sig { params(attributes: T.any(Symbol, T::Hash[Symbol, T.untyped])).returns(T::Hash[Symbol, T.untyped]) }
    def field_attributes(attributes)
      if attributes.is_a?(Hash)
        control_html = attributes.fetch(:control_html, {})
        css_class = control_html.delete(:class)
        control_html[:class] = css_class&.include?("group-fields") ? css_class : "field #{css_class}"
        return control_html
      end
      {}
    end

    sig { params(field_name: T.any(Symbol, String), input_type: T.any(Symbol, String), css_classes: T.nilable(String)).returns(T::Hash[Symbol, T.untyped]) }
    def input_attributes(field_name, input_type, css_classes = "")
      css_classes = [input_type, field_name] + (css_classes&.split(" ") || [])
      key = resource_class.model_name.i18n_key

      {
        class: css_classes.uniq.join(" "),
        placeholder: t("form.placeholders.#{key}.#{field_name}", default: ""),
        maxlength: t("form.maxlength.#{key}.#{field_name}", default: t("form.maxlength.size"))
      }
    end

    # TODO: This API is not consistent with #input_attributes
    sig { params(model: ActiveRecord::Base, field: Symbol).returns(T.nilable(String)) }
    def field_help(model, field:)
      help = t("form.help.#{model.model_name.i18n_key}.#{field}", default: t("form.help.#{field}"))
      help = "" if help.include?("translation missing:")

      return content_tag(:p, help, class: "help") if help.present?
      ""
    end
  end
end
