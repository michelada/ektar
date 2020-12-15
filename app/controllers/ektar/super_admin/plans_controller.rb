# typed: false
# frozen_string_literal: true

module Ektar
  module SuperAdmin
    class PlansController < ApplicationController
      resourceful(list_attributes: %i[name price active updated_at],
                  form_attributes: {name: :input,
                                    description: :rich_text,
                                    free: :checkbox,
                                    trial: {type: :number, options: {control: {control_css: "is-one-quarter"}}},
                                    price: {type: :number, options: {control: {control_css: "is-one-quarter"}}},
                                    price_currency: :currency,
                                    active: :checkbox},
                  show_attributes: %i[name description free trial price active],
                  except: [:show],
                  namespace: :super_admin,
                  policy_class: Ektar::PlanPolicy,
                  resource_class: Ektar::Plan)

      sig { void }
      def create
        create! do |success|
          success.response { redirect_to super_admin_plans_path }
        end
      end

      sig { void }
      def update
        update! do |success|
          success.response { redirect_to super_admin_plans_path }
        end
      end

      sig { void }
      def destroy
        object = Ektar::Plan.find_by!(find_by_param => params[:id])

        authorize object

        object.active = false

        object.save
        set_flash(errors: object.errors, klass: resource_class.model_name.element, active: action_name)

        redirect_to collection_path
      end

      sig { params(resource: T.untyped).returns(T::Boolean) }
      def allow_delete?(resource)
        resource.active
      end

      private

      sig { returns(ActionController::Parameters) }
      def secure_params
        params.require_typed(:plan, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
      end
    end
  end
end
