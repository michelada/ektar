# typed: strict
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    # before_action :verify_role, only: [:create, :destroy]
    extend T::Sig

    resourceful(list_attributes: %i[id email updated_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id, except: :new)

    sig { void }
    def new
      @resource = T.let(Ektar::User.new, T.nilable(Ektar::User))
      @resource.memberships.build.build_organization if @resource.present?

      render :new, layout: "ektar/users"
    end

    sig { void }
    def create
      @resource = Ektar::User.new secure_params

      @resource.tap do |user|
        user.last_ip = format_ip(request.remote_ip)
        user.last_activity_at = Time.now

        user.memberships.first.tap do |membership|
          membership.role = "admin"
          membership.owner = true
        end
      end

      @resource = Ektar::User.new params
      if @resource.save
        cookies.encrypted["#{Ektar.configuration.session_name}_remember_me"] = @resource.global_id
        redirect_to users_path
      else
        @resource.memberships.build(role: "admin").build_organization if @resource.memberships.empty?
        render :new, layout: "ektar/users"
      end
    end

    sig { returns(String) }
    def new_resource_path
      registration_path
    end

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
    end

    sig { returns(TrueClass) }
    def verify_role
      redirect_to root_path unless resource.admin?
      true
    end
  end
end
