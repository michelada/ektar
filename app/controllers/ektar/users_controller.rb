# typed: strict
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    # before_action :verify_role, only: [:create, :destroy]
    # include Ektar::Concerns::Resourceful
    extend T::Sig

    resourceful(resource_class: Ektar::User,
                list_attributes: %i[id email updated_at])

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
    end

    sig { returns(TrueClass) }
    def verify_role
      redirect_to root_path unless resource.admin?
      true
    end
  end
end
