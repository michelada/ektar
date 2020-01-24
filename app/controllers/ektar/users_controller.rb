# typed: false
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    # before_action :verify_role, only: [:create, :destroy]
    extend T::Sig

    resourceful(list_attributes: %i[id email updated_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id, except: :new)

    def new
      @resource = T.let(Ektar::User.new, T.nilable(Ektar::User))
      @resource.memberships.build(role: "admin").build_organization if @resource.present?

      render :new, layout: "ektar/users"
    end

    def create
      @user = Ektar::User.new secure_params

      unless @user.memberships.empty?
        @user.save
        # cookies.encrypted["#{Ektar.configuration.session_name}_remember_me"] = @user.global_id
        redirect_to users_path
      else
        render :new, alert: "Error al guardar el usuario"
      end
    end

    def new_resource_path
      registration_path
    end

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require(:user).permit(form_attributes.keys, memberships_attributes: [{organization_attributes: [:name]}])
      # params.require_typed(user: [ :organization ], TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
    end

    sig { returns(TrueClass) }
    def verify_role
      redirect_to root_path unless resource.admin?
      true
    end
  end
end
