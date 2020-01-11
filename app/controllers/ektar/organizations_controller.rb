# frozen_string_literal: true

require_dependency "ektar/concerns/resourceful"

module Ektar
  class OrganizationsController < ApplicationController
    include Resourceful

    LIST_ATTRIBUTES = %i[id name enable updated_at].freeze
    FORM_ATTRIBUTES = {name: :input, enable: :checkbox}.freeze
    SHOW_ATTRIBUTES = %i[name enable updated_at].freeze

    resourceful :ektar_organization,
      :index, :new, :create, :edit, :update, :show

    before_action :authenticate_superadmin!, except: :show

    def destroy
      object = find_resource
      object.enable = false

      object.save
      set_flash(errors: object.errors, klass: resource_class.model_name.element, action: action_name)

      redirect_to collection_path
    end

    def allow_delete?(resource)
      resource.enable
    end

    private

    def authenticate_superadmin!
      session[:super_admin] = authenticate_or_request_with_http_basic("Restricted Access") { |username, password|
        username == Ektar.configuration.organization_username && password == Ektar.configuration.organization_password
      }

      return render status: :not_authorized unless super_admin?
    end

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
      params.require(:organization).permit(form_attributes.keys)
    end
  end
end
