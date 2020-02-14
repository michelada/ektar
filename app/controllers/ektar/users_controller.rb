# typed: false
# frozen_string_literal: true

module Ektar
  class UsersController < ResourcefulController
    before_action :is_normal_user, only: [:new, :create, :update]
    extend T::Sig
    include Pagy::Backend

    resourceful(list_attributes: %i[email updated_at last_activity_at],
                form_attributes: {email: :input, password: :password, password_confirmation: :password},
                show_attributes: %i[id email updated_at],
                find_by: :global_id,
                except: [:new, :index, :create, :delete],
                resource_class: Ektar::User)

    sig { void }
    def index
      authorize current_organization, policy_class: Ektar::UserPolicy

      index! { |scope| current_organization.users }

      render layout: "ektar/application"
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
      registrations_path
    end

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
    end

    sig { void }
    def is_normal_user
      redirect_to users_path if super_admin?
    end
  end
end
