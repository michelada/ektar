# typed: false
# frozen_string_literal: true

module Ektar
  module Admin
    class InvitationsController < ApplicationController
      extend T::Sig

      skip_before_action :authenticate_admin!, only: [:create, :edit]

      resourceful(form_attributes: {email: :input,
                                    invitation_token: :hidden,
                                    ektar_organization_id: :hidden},
                  resource_class: Ektar::Invitation,
                  policy_class: Ektar::InvitationPolicy)

      def new
        new! do |resource|
          resource.ektar_organization_id = current_organization.id
        end
      end

      sig { void }
      def create
        organization_id = params.dig(:invitation, :ektar_organization_id)
        user_email = params.dig(:invitation, :email)

        organization = Ektar::Organization.find_by(id: organization_id)
        invitation_token = generate_invitation_token(user_email, organization.global_id)

        @resource = Ektar::Invitation.new(invitation_params.merge(invitation_token: invitation_token))

        if @resource.save
          Ektar::UserMailer.with(organization: organization, invitation_token: invitation_token, email: @resource.email).new_invitation_email.deliver_now
          flash[:notice] = t("flash.create.invitation.notice", email: user_email)
          redirect_to ektar.root_path
        else
          flash[:alert] = t("flash.create.invitation.alert")
          render :new
        end
      end

      def edit
        invitation_token = params.dig(:invitation_token)
        invitation = Ektar::Invitation.find_by(invitation_token: invitation_token)

        user = Ektar::User.find_by(email: invitation.email)

        if user
          update_session_cookie(user: user)

          if build_user_membership.save
            flash[:notice] = t("edit.invitations.notice")
          else
            flash[:alert] = t("edit.invitations.alert")
          end
          redirect_to ektar.root_path
        else
          redirect_to ektar.new_reset_password_path(invitation_token: invitation_token)
        end
      end

      private

      sig { params(email: String, organization_global_id: String).returns(String) }
      def generate_invitation_token(email, organization_global_id)
        verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
        verifier.generate("#{email}@#{organization_global_id}")
      end

      sig { returns(ActionController::Parameters) }
      def invitation_params
        params.require_typed(:invitation, TA[ActionController::Parameters].new).permit(T.must(form_attributes).keys)
      end

      def build_user_membership
        invitation_token = params.dig(:invitation_token)
        invitation = Ektar::Invitation.find_by(invitation_token: invitation_token)

        user = Ektar::User.find_by(email: invitation.email)

        user.memberships.new(ektar_organization_id: invitation.ektar_organization_id)
      end
    end
  end
end
