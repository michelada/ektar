# typed: false
# frozen_string_literal: true

module Ektar
  module SuperAdmin
    class UsersController < ApplicationController
      extend T::Sig
      include Pagy::Backend

      resourceful(list_attributes: %i[email updated_at last_activity_at blocked_at],
                  form_attributes: {email: :input, password: :password, password_confirmation: :password},
                  show_attributes: %i[id email updated_at],
                  find_by: :global_id,
                  except: [:edit, :update],
                  namespace: :super_admin,
                  resource_class: Ektar::User,
                  policy_class: Ektar::UserPolicy)

      sig { void }
      def index
        index! { |scope| scope.where(super_admin: true) }
      end

      sig { void }
      def destroy
        object = Ektar::User.find_by!(find_by_param => params[:id])
        object&.update blocked_at: Time.zone.now

        set_flash(errors: object.errors, klass: resource_class.model_name.element, active: action_name)

        redirect_to collection_path
      end

      private

      sig { params(resource: T.untyped).returns(T::Boolean) }
      def allow_delete?(resource)
        !resource.blocked? && resource.id != current_user.id
      end

      sig { returns(Symbol) }
      def link_attribute
        :email
      end

      sig { returns(String) }
      def new_resource_path
        ektar.registrations_path
      end

      sig { returns(ActionController::Parameters) }
      def secure_params
        params.require(:user).permit(T.must(form_attributes).keys, memberships_attributes: [{organization_attributes: [:name]}])
      end
    end
  end
end
