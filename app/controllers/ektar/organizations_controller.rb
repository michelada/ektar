require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/index"
require_dependency "ektar/concerns/new"

module Ektar
  class OrganizationsController < ApplicationController
    include Index
    include New

    private

    def model_name
      Organization
    end

    def list_attributes
      %w[id name enable]
    end
    helper_method :model_name, :list_attributes
  end
end
