# frozen_string_literal: true

require_dependency "ektar/concerns/resourceful"

module Ektar
  class OrganizationsController < ApplicationController
    include Resourceful

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

    def super_admin?
      @super_admin ||= session[:super_admin].present?
    end

    def list_attributes
      %i[id name enable updated_at]
    end

    def form_attributes
      {name: :input, enable: :checkbox}
    end

    def show_attributes
      %i[name enable updated_at]
    end

    def secure_params
      params.require(:organization).permit(:name, :enable)
    end

    helper_method :super_admin?
  end
end
