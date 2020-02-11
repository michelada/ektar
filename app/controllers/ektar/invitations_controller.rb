# typed: false
# frozen_string_literal: true

module Ektar
  class InvitationsController < ResourcefulController
    extend T::Sig

    resourceful(form_attributes: {email: :input,
                                  invitation_token: :hidden,
                                  ektar_organization_id: :hidden,})

    def new
      new! do |resource|
        resource.ektar_organization_id = current_organization.id
      end
    end

    sig { void }
    def create
      organization_id = params.dig(:invitation, :ektar_organization_id)
      user_email = params.dig(:invitation, :email)

      verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)

      organization = Ektar::Organization.find_by(id: organization_id)
      invitation_token = verifier.generate("#{user_email}@#{organization.global_id}")

      @resource = Ektar::Invitation.new(invitation_params.merge(invitation_token: invitation_token))

      if @resource.save
        Ektar::UserMailer.with(organization: organization, invitation_token: invitation_token, email: @resource.email).new_invitation_email.deliver_now
        flash[:notice] = t("flash.create.invitation.notice", email: user_email)
        redirect_to users_path
      else
        flash[:alert] = t("flash.create.invitation.alert")
        render :new
      end
    end

    private

    sig { returns(ActionController::Parameters) }
    def invitation_params
      params.require_typed(:invitation, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
    end
  end
end
