# frozen_string_literal: true

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

    def form_new_attributes
      { name: :text, enable: :checkbox }
    end

    def form_show_attributes
      %w[name enable]
    end

    helper_method :model_name, :list_attributes
  end
end
