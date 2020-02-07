module Ektar
  class UserMailer < ApplicationMailer
    def new_invitation_email
      @user = params[:user]

      mail(to: @user.email, subject: t("mailers.invitation.subject", params[:current_user]))
    end
  end
end
