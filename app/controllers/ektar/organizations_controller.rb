# frozen_string_literal: true

require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/create"

module Ektar
  class OrganizationsController < ApplicationController
    include Index
    include New
    include Create

    private

    def model_name
      Organization
    end

    def list_attributes
      %w[id name enable]
    end

    def form_new_attributes
      { name: :input, enable: :checkbox }
    end

    def form_show_attributes
      %w[name enable]
    end

    def create_secure_params
      params.require(:organization).permit(:name, :enable)
    end
    helper_method :model_name, :list_attributes, :form_new_attributes, :create_secure_params
  end
end
