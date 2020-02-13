# typed: false
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    extend T::Sig
    include Pagy::Backend

    resourceful(list_attributes: %i[email updated_at last_activity_at blocked_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id, except: [:new, :index, :create, :delete])

    sig { void }
    def index
      authorize current_organization, policy_class: Ektar::UserPolicy

      index! do |scope|
        if current_user.super_admin?
          Ektar::User.super_admins
        else
          current_organization.users
        end
      end

      render layout: "ektar/application"
    end

    sig { void }
    def new
      @resource = T.let(Ektar::User.new, T.nilable(Ektar::User))
      @resource.memberships.build.build_organization if @resource.present?

      render :new, layout: "ektar/users"
    end

    sig { void }
    def create
      @resource = Ektar::User.new(secure_params).tap do |user|
        user.last_ip = format_ip(request.remote_ip)
        user.last_activity_at = Time.zone.now

        user.memberships.first.tap do |membership|
          if membership.present?
            membership.role = "admin"
            membership.owner = true
          end
        end
      end

      if @resource.save
        update_session_cookie(user: @resource.reload, organization: @resource.organizations.first)
        redirect_to root_path
      else
        @resource.memberships.build(role: "admin").build_organization if @resource.memberships.empty?
        render :new, layout: "ektar/users"
      end
    end

    sig { void }
    def destroy
      object = Ektar::User.find_by!(find_by_param => params[:id])
      object.membership&.update blocked_at: Time.zone.now

      set_flash(errors: object.errors, klass: resource_class.model_name.element, active: action_name)

      redirect_to collection_path
    end

    private

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_delete?(resource)
      current_organization.has_active_user?(resource) || current_user.super_admin?
    end

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_edit?(resource)
      current_organization.has_active_user?(resource) && !current_user.super_admin?
    end

    sig { returns(Symbol) }
    def link_attribute
      :email
    end

    sig { returns(String) }
    def new_resource_path
      registration_path
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
    end
  end
end
