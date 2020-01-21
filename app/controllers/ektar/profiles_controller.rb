# frozen_string_literal: true

# typed: strict

module Ektar
  class ProfilesController < ApplicationController
    extend T::Sig

    private

    sig { returns(T.class_of(Ektar::Profile)) }
    def resource_class
      Profile
    end

    sig { returns(String) }
    def route_prefix
      "organization_user"
    end

    sig { returns(T::Hash[Symbol, Symbol]) }
    def form_attributes
      {image_profile: :file, name: :input, ektar_user_id: :input}
    end

    sig { returns(T::Hash[Symbol, Symbol]) }
    def form_show_attributes
      {image_profile: :image, name: :input}
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:profile, TA[ActionController::Parameters].new).permit(:name, :image_profile, :ektar_user_id)
    end

    helper_method :resource_class, :form_attributes, :form_show_attributes, :route_prefix
  end
end
