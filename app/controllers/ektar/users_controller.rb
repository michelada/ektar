# typed: true
# frozen_string_literal: true

module Ektar
  class UsersController < ApplicationController
    # before_action :verify_role, only: [:create, :destroy]
    include Ektar::Concerns::Resourceful

    LIST_ATTRIBUTES = %i[id email updated_at].freeze
    FORM_ATTRIBUTES = {email: :input, encrypted_password: :password}.freeze
    SHOW_ATTRIBUTES = %i[id email updated_at].freeze

    resourceful :ektar_user,
      :index, :new, :create, :edit, :update, :show, :destroy

    private

    def list_attributes
      LIST_ATTRIBUTES
    end

    def form_attributes
      FORM_ATTRIBUTES
    end

    def show_attributes
      SHOW_ATTRIBUTES
    end

    def secure_params
      params.require(:user).permit(form_attributes.keys)
    end

    def verify_role
      redirect_to root_path unless @user.admin?
      true
    end
  end
end
