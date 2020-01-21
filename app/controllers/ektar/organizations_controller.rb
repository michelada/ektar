# typed: strict
# frozen_string_literal: true

module Ektar
  class OrganizationsController < ApplicationController
    include Ektar::Concerns::Resourceful
    extend T::Sig

    LIST_ATTRIBUTES = T.let(%i[id name enable updated_at].freeze, T::Array[Symbol])
    FORM_ATTRIBUTES = T.let({name: :input, enable: :checkbox}.freeze, T::Hash[Symbol, Symbol])
    SHOW_ATTRIBUTES = T.let(%i[name enable updated_at].freeze, T::Array[Symbol])

    resourceful :ektar_organization,
      :index, :new, :create, :edit, :update, :show

    before_action :authenticate_superadmin!, except: :show

    sig { void }
    def destroy
      object = Ektar::Organization.find_by!(id: params[:id])
      object.enable = false

      object.save
      set_flash(errors: object.errors, klass: resource_class.model_name.element, action: action_name)

      redirect_to collection_path
    end

    sig { params(resource: Ektar::Organization).returns(T::Boolean) }
    def allow_delete?(resource)
      resource.enable?
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
      params.require_typed(:organization, TA[ActionController::Parameters].new).permit(form_attributes.keys)
    end
  end
end
