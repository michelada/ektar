# typed: false
# frozen_string_literal: true

module Ektar
  module Admin
    class UsersController < BaseController
      extend T::Sig
      include Pagy::Backend

      before_action :organization_has_plan, only: [:index]

      resourceful(list_attributes: %i[email updated_at last_activity_at blocked_at],
                  form_attributes: {email: :input, password: :password, password_confirmation: :password},
                  show_attributes: %i[id email updated_at],
                  find_by: :global_id,
                  except: [:delete],
                  resource_class: Ektar::User)

      sig { void }
      def index
        authorize current_organization, policy_class: Ektar::UserPolicy

        index! { |scope| current_user.super_admin? ? scope.where(super_admin: true) : scope.joins(:memberships).where(memberships: [organization: current_organization]) }

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
        current_organization&.has_active_user?(resource) || current_user.super_admin?
      end

      sig { params(resource: T.untyped).returns(T::Boolean) }
      def allow_edit?(resource)
        !!(current_organization&.has_active_user?(resource) && !current_user.super_admin?)
      end

      sig { returns(Symbol) }
      def link_attribute
        :email
      end

      sig { returns(ActionController::Parameters) }
      def secure_params
        params.require_typed(:user, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
      end

      sig { void }
      def organization_has_plan
        return if current_organization&.plan_present?

        redirect_to ektar.new_admin_select_plan_path
      end
    end
  end
end
