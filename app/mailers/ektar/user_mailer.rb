module Ektar
  class UserMailer < ApplicationMailer
    def new_invitation_email
      @user_email = params[:email]
      @organization = params[:organization]

      mail(to: @user_email, subject: t("mailers.invitation.subject", @organization.name))
    end
  end
end
