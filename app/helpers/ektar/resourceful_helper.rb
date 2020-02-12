# typed: strict
# frozen_string_literal: true

module Ektar
  module ResourcefulHelper
    include ApplicationHelper
    extend T::Sig

    sig { params(attribute_options: T.untyped).returns(T::Hash[T.untyped, T.untyped]) }
    def resource_attributes(attribute_options)
      Hash.new({}).merge attribute_options.is_a?(Symbol) ? {type: attribute_options} : attribute_options
    end

    sig { params(hash1: T::Hash[Symbol, T.untyped], hash2: T::Hash[Symbol, T.untyped]).returns(T::Hash[Symbol, T.untyped]) }
    def merge_resource_attributes(hash1, hash2)
      hash2.keys.each do |key|
        if hash1.key?(key)
          hash1[key] += " #{hash2[key]}"
        else
          hash1[key] = hash2[key]
        end
      end

      hash1
    end

    sig { params(attribute_name: T.untyped, options: T::Hash[T.untyped, T.untyped]).returns(T.untyped) }
    def options_for_input(attribute_name, options)
      input_attributes(attribute_name).merge(options)
    end
  end
end
