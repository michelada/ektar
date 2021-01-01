# typed: ignore
# frozen_string_literal: true

module Ektar
  module Admin
    class InvitationsController < ApplicationController
      include Ektar::Concerns::Tokens
      layout false

      resourceful(form_attributes: {email: {type: :input, input_html: {class: "input email", maxlength: 50}}},
                  only: [:new, :create],
                  resource_class: Ektar::Invitation,
                  policy_class: Ektar::InvitationPolicy)

      sig { void }
      def new
        new! do |resource|
          resource.ektar_organization_id = current_organization.id
        end
      end

      sig { void }
      def create
        authorize current_organization, policy_class: policy_class

        user_email = params.dig(:invitation, :email)&.strip

        organization = current_organization
        invitation_token = generate_invitation_token(organization.global_id)

        @resource = Ektar::Invitation.find_by(email: user_email)

        if @resource.present?
          @resource.update_column(:invitation_token, invitation_token)
        else
          @resource = Ektar::Invitation.new(invitation_params).tap do |invitation|
            invitation.invitation_token = invitation_token
            invitation.organization = organization
            invitation.email = user_email
            invitation.save
          end
        end

        create! do |success|
          success.response do
            Ektar::InvitationMailer.with(host: full_host, token: token_to_url(invitation_token), invitation: @resource).invite.deliver_now
            flash[:notice] = t("flash.create.invitation.notice", email: @resource.email)
            redirect_to ektar.admin_users_path
          end
        end
      end

      private

      sig { returns(String) }
      def collection_path
        ektar.admin_invitations_path
      end

      sig { params(resource: ActiveRecord::Base).returns(String) }
      def resource_path(resource)
        ektar.admin_invitations_path(resource)
      end

      sig { returns(ActionController::Parameters) }
      def invitation_params
        params.require(:invitation).permit(T.must(form_attributes).keys)
      end
    end
  end
end
