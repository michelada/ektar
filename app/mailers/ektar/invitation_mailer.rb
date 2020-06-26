# typed: true
module Ektar
  class InvitationMailer < ApplicationMailer
    def invite
      @invitation = params[:invitation]

      mail(to: @invitation.email, subject: t("mailers.invitation.subject", organization_name: @invitation.organization.name))
    end
  end
end
