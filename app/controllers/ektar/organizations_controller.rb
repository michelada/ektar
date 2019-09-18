# frozen_string_literal: true

require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/show"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/create"
require_dependency "ektar/concerns/edit"
require_dependency "ektar/concerns/update"
require_dependency "ektar/concerns/destroy"

module Ektar
  class OrganizationsController < ApplicationController
    include New
    include Index
    include Show
    include Create
    include Edit
    include Update
    include Destroy

    before_action :authenticate_superadmin!, except: :show

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

    def model_name
      Organization
    end

    def list_attributes
      %w[id name enable updated_at]
    end

    def form_attributes
      {name: :input, enable: :checkbox}
    end

    def form_show_attributes
      {name: :input, enable: :checkbox}
    end

    def secure_params
      params.require(:organization).permit(:name, :enable)
    end

    helper_method :model_name, :list_attributes, :form_attributes, :form_show_attributes, :super_admin?
  end
end
