# typed: true
# frozen_string_literal: true

module Ektar
  class OrganizationsController < Ektar::ResourcefulController
    extend T::Sig

    resourceful(list_attributes: %i[id name enable updated_at],
                form_attributes: {name: :input, enable: :checkbox},
                show_attributes: %i[name enable updated_at],
                find_by: :global_id,
                policy_class: Ektar::OrganizationPolicy)

    def index
      authorize resource, policy_class: policy_class
      index!
    end

    def show
      show! { |resource| authorize resource }
    end

    def new
      new! { |resource| authorize resource }
    end

    def edit
      edit! { |resource| authorize resource }
    end

    sig { void }
    def destroy
      object = Ektar::Organization.find_by!(find_by_param => params[:id])

      authorize object

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
