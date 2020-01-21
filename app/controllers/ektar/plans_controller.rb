# typed: strict
# frozen_string_literal: true

module Ektar
  class PlansController < ApplicationController
    include Ektar::Concerns::Resourceful
    extend T::Sig

    LIST_ATTRIBUTES = T.let(%i[name price active updated_at].freeze, T::Array[Symbol])
    FORM_ATTRIBUTES = T.let({name: :input, description: :rich_text, active: :checkbox, trial: :input, free: :checkbox, price_cents: :number, price_currency: :currency}.freeze, T::Hash[T.untyped, T.untyped])
    SHOW_ATTRIBUTES = T.let(%i[name description free trial active price].freeze, T::Array[Symbol])

    resourceful :ektar_plan,
      :index, :new, :create, :edit, :update, :show

    before_action :authenticate_superadmin!, except: :show

    sig { void }
    def destroy
      object = find_resource
      object.active = false

      object.save
      set_flash(errors: object.errors, klass: resource_class.model_name.element, active: action_name)

      redirect_to collection_path
    end

    sig { params(resource: Ektar::Plan).returns(T::Boolean) }
    def allow_delete?(resource)
      resource.active
    end

    private

    sig { returns(T::Array[Symbol]) }
    def list_attributes
      LIST_ATTRIBUTES
    end

    sig { returns(T::Hash[Symbol, Symbol]) }
    def form_attributes
      FORM_ATTRIBUTES
    end

    sig { returns(T::Array[Symbol]) }
    def show_attributes
      SHOW_ATTRIBUTES
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:plan, TA[ActionController::Parameters].new).permit(form_attributes.keys)
    end

    sig { returns(Ektar::Plan) }
    def find_resource
      Ektar::Plan.find(params[:id])
    end
  end
end
