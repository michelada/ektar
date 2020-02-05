# typed: strict
# frozen_string_literal: true

module Ektar
  class PlansController < ResourcefulController
    extend T::Sig

    resourceful(list_attributes: %i[name price active updated_at],
                form_attributes: {name: :input,
                                  description: :rich_text,
                                  active: :checkbox,
                                  trial: :input,
                                  free: :checkbox,
                                  price_cents: :number,
                                  price_currency: :currency,},
                show_attributes: %i[name description free trial active price])

    before_action :verify_super_admin!

    sig { void }
    def destroy
      object = Ektar::Plan.find_by!(find_by_param => params[:id])
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
