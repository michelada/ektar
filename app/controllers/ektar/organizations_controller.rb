# typed: strict
# frozen_string_literal: true

module Ektar
  class OrganizationsController < ResourcefulController
    extend T::Sig

    resourceful(resource_class: Ektar::Organization,
                list_attributes: %i[id name enable updated_at],
                form_attributes: {name: :input, enable: :checkbox},
                show_attributes: %i[name enable updated_at])

    before_action :authenticate_superadmin!, except: :show

    sig { void }
    def destroy
      object = Ektar::Organization.find(params[:id])
      object.enable = false

      object.save
      set_flash(errors: object.errors, klass: resource_class.model_name.element, action: action_name)

      redirect_to collection_path
    end

    sig { params(resource: T.untyped).returns(T::Boolean) }
    def allow_delete?(resource)
      resource.enable?
    end

    private

    sig { returns(ActionController::Parameters) }
    def secure_params
      params.require_typed(:organization, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
    end
  end
end
