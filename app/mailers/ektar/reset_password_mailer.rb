# typed: ignore
# frozen_string_literal: true

module Ektar
  class ResetPasswordMailer < ApplicationMailer
    sig { void }
    def reset
      @user = params[:user]
      @token = params[:token]

      mail(to: @user.email, subject: t("mailers.reset_password.subject"))
    end
  end
end
