# typed: strict
# frozen_string_literal: true

module Ektar
  class UsersController < ApplicationController
    # before_action :verify_role, only: [:create, :destroy]
    include Ektar::Concerns::Resourceful
    extend T::Sig

    LIST_ATTRIBUTES = T.let(%i[id email updated_at].freeze, T::Array[Symbol])
    FORM_ATTRIBUTES = T.let({email: :input, password: :password, password_confirmation: :password}.freeze, T::Hash[Symbol, Symbol])
    SHOW_ATTRIBUTES = T.let(%i[id email updated_at].freeze, T::Array[Symbol])

    resourceful :ektar_user,
      :index, :new, :create, :edit, :update, :show, :destroy

    private

    sig { returns(T::Array[Symbol]) }
    def list_attributes
      LIST_ATTRIBUTES
    end

    sig { returns(T::Hash[Symbol, Symbol]) }
    def form_attributes
      FORM_ATTRIBUTES
    end

    sig { returns(T::Array[Symbol]) }
    def show_attributes
      SHOW_ATTRIBUTES
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(form_attributes.keys)
    end

    sig { returns(TrueClass) }
    def verify_role
      redirect_to root_path unless resource.admin?
      true
    end
  end
end
