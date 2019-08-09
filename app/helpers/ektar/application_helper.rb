require "webpacker/helper"

module Ektar
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Ektar.webpacker
    end

    def select_options(attribute_name)
      options = []
      attributes_options.each do |attribute|
        if attribute.keys[0] == attribute_name
          attribute.values[0].split(',') do |option|
            if clean_data(option).nil?
              options += [t('forms.dropdown_options', option: option)]
            else
              options += [clean_data(option)]
            end
          end
        end
      end
      options
    end

    def clean_data(option)
      option.to_i if option.match(/\A[+-]?\d+?(\.\d+)?\Z/)
    end
  end
end
