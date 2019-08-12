require_dependency "ektar/application_controller"
require_dependency "ektar/concerns/new"
require_dependency "ektar/concerns/create"
require_dependency "ektar/concerns/edit"
require_dependency "ektar/concerns/update"
require_dependency "ektar/concerns/destroy"
require_dependency "ektar/concerns/show"

module Ektar
  class ProfilesController < ApplicationController
    include New
    include Create
    include Edit
    include Update
    include Destroy
    include Show

    private

    def model_name
      Profile
    end

    def form_attributes
      { image_profile: :file, name: :input, ektar_user_id: :input}
    end

    def form_show_attributes
      { name: :input, image_profile: :image, ektar_user_id: :input}
    end

    def secure_params
      params.require(:profile).permit(:name, :image_profile, :ektar_user_id)
    end

    helper_method :model_name, :form_attributes, :form_show_attributes
  end
end
