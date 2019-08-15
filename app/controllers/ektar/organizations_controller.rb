# frozen_string_literal: true

# require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/create"
require_dependency "ektar/concerns/edit"
require_dependency "ektar/concerns/update"
require_dependency "ektar/concerns/destroy"
require_dependency "ektar/concerns/show"

module Ektar
  class OrganizationsController < ApplicationController
    include Index
    include New
    include Create
    include Edit
    include Update
    include Destroy
    include Show

    private

    def model_name
      Organization
    end

    def list_attributes
      %w[id name enable]
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

    helper_method :model_name, :list_attributes, :form_attributes, :form_show_attributes
  end
end
