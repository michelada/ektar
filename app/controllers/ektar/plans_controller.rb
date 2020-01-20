require_dependency "ektar/application_controller"

module Ektar
  class PlansController < ApplicationController
    include Ektar::Concerns::Resourceful

    LIST_ATTRIBUTES = %i[name price_cents active updated_at].freeze
    FORM_ATTRIBUTES = {name: :input, active: :checkbox, trial: :input, free: :checkbox, price_cents: :number, price_currency: :currency}.freeze
    SHOW_ATTRIBUTES = %i[name free trial active price_cents price_currency].freeze

    resourceful :ektar_plan,
      :index, :new, :create, :edit, :update, :show

    before_action :authenticate_superadmin!, except: :show

    def destroy
      object = find_resource
      object.active = false

      object.save
      set_flash(errors: object.errors, klass: resource_class.model_name.element, active: action_name)

      redirect_to collection_path
    end

    def allow_delete?(resource)
      resource.active
    end

    private

    def list_attributes
      LIST_ATTRIBUTES
    end

    def form_attributes
      FORM_ATTRIBUTES
    end

    def show_attributes
      SHOW_ATTRIBUTES
    end

    def secure_params
      params.require(:plan).permit(form_attributes.keys)
    end

    def find_resource
      Ektar::Plan.find(params[:id])
    end
  end
end
