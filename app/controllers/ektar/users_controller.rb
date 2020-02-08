# typed: ignore
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    before_action :is_normal_user, only: [:new, :create, :update]
    extend T::Sig
    include Pagy::Backend

    resourceful(list_attributes: %i[email updated_at last_activity_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id, except: [:new, :index, :create, :delete])

    sig { void }
    def index
      filter_organization(params.dig("/ektar/usuarios", "organization_id"))
      authorize current_organization, policy_class: Ektar::UserPolicy

      index! { |scope| current_organization.users }

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

    sig { params(global_id: T.nilable(String)).void }
    def filter_organization(global_id)
      if global_id.present?
        @organization = Ektar::Organization.joins(:users).find_by(find_by_param => global_id)
        update_session_cookie(organization: @organization)
      end
    end
  end
end
