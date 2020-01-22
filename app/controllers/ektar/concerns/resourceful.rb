# typed: strict
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Resourceful
      extend ActiveSupport::Concern
      include Kernel
      extend T::Sig

      included do
        sig { params(resource: Class).returns(T::Boolean) }
        def allow_delete?(resource)
          true
        end

        unless respond_to?(:list_attributes)

          sig { returns(T::Array[Symbol]) }
          def list_attributes
            T.unsafe(self).resource.attribute_names.map(&:to_sym)
          end
        end

        unless respond_to?(:form_attributes)

          sig { returns(T::Hash[Symbol, Symbol]) }
          def form_attributes
            Hash[(list_attributes - %i[id updated_at created_at]).map { |attr| [attr, :input] }]
          end
        end

        unless respond_to?(:show_attributes)

          sig { returns(T::Array[Symbol]) }
          def show_attributes
            T.unsafe(self).resource.attribute_names.map(&:to_sym)
          end
        end

        T.unsafe(self).helper_method(:link_attribute, :allow_delete?, :new_resource_path, :edit_resource_path,
          :resource_path, :collection_path, :delete_confirmation, :list_attributes, :form_attributes,
          :show_attributes)
      end

      class_methods do
        sig { params(model_name: Symbol, actions: String).void }
        def resourceful(model_name, *actions)
          T.unsafe(self).class_attribute :model_name, instance_writer: false
          T.unsafe(self).self.model_name = model_name

          Array(actions).each do |name|
            case name
            when :index then T.unsafe(self).include Ektar::Concerns::Index
            when :new then T.unsafe(self).include Ektar::Concerns::New
            when :create then T.unsafe(self).include Ektar::Concerns::Create
            when :edit then T.unsafe(self).include Ektar::Concerns::Edit
            when :update then T.unsafe(self).include Ektar::Concerns::Update
            when :show then T.unsafe(self).include Ektar::Concerns::Show
            when :destroy then T.unsafe(self).include Ektar::Concerns::Destroy
            end
          end
        end
      end
    end
  end
end
