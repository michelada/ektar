# typed: ignore
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    before_action :is_normal_user, only: [:new, :create, :update]
    extend T::Sig
    include Pagy::Backend

    resourceful(list_attributes: %i[email updated_at last_activity_at invitation_created_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id, except: [:new, :index, :create, :delete])

    sig { void }
    def index
      authorize current_organization, policy_class: Ektar::UserPolicy

      index! do |scope|
        scope = current_organization.users
      end

      @user_organizations = T.must(current_user).admin_of.pluck(:name, :global_id)
      render "index", layout: "ektar/application"
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
        cookies.encrypted[session_cookie_name] = {
          value: {
            user: @resource.global_id,
            organization: @resource.memberships.first.organization.global_id,
          },
          expires: Ektar.configuration.session_expiration,
        }
        redirect_to users_path
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
      current_organization.has_active_user?(resource)
    end

    sig { returns(String) }
    def new_resource_path
      registration_path
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
    end

    sig { void }
    def is_normal_user
      redirect_to users_path if super_admin?
    end

    def current_organization
      @current_organization ||=
        org_id = params.dig("/ektar/usuarios", "organization_id") || session_cookie["organization"]

        # This must be removed whenever you're able to choose an organization after logging in
        # By now it just sets the organization (Task in SessionsController:19)
        org_id = current_user.organizations.first.global_id if current_user && org_id.nil?

        if org_id
          @organization = Ektar::Organization.joins(:users).find_by(find_by_param => org_id)
          @current_organization = nil
          current_organization = @organization
        end

        org_id ? @organization : nil
    end
  end
end
