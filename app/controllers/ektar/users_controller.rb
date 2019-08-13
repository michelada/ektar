require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/create"
require_dependency "ektar/concerns/edit"
require_dependency "ektar/concerns/update"
require_dependency "ektar/concerns/destroy"
require_dependency "ektar/concerns/show"

module Ektar
  class UsersController < ApplicationController
    include Index
    include New
    include Create
    include Edit
    include Update
    include Destroy
    include Show

    private

    def model_name
      User
    end

    def route_prefix
      'organization'
    end

    def list_attributes
      %w[id email ektar_organization_id]
    end

    def form_attributes
      {email: :input, encrypted_password: :input, ektar_organization_id: :select}
    end

    def attributes_options
      [{ektar_organization_id: Ektar::Organization.list_name_available}]
    end

    def form_show_attributes
      {email: :input, ektar_organization_id: :input}
    end

    def secure_params
      params.require(:user).permit(:email, :encrypted_password, :ektar_organization_id)
    end

    helper_method :model_name, :list_attributes, :form_attributes, :attributes_options, :form_show_attributes, :route_prefix
  end
end
