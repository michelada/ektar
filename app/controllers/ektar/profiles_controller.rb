# typed: false

module Ektar
  class ProfilesController < ApplicationController
    private

    def resource_class
      Profile
    end

    def route_prefix
      "organization_user"
    end

    def form_attributes
      {image_profile: :file, name: :input, ektar_user_id: :input}
    end

    def show_attributes
      {image_profile: :image, name: :input}
    end

    def secure_params
      params.require(:profile).permit(:name, :image_profile, :ektar_user_id)
    end

    helper_method :resource_class, :form_attributes, :show_attributes, :route_prefix
  end
end
