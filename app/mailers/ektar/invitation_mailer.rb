# typed: true
module Ektar
  class InvitationMailer < ApplicationMailer
    sig { void }
    def invite
      @invitation = params[:invitation]
      @token = params[:token]

      mail(to: @invitation.email, subject: t("mailers.invitation.subject", organization_name: @invitation.organization.name))
    end
  end
end
