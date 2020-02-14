# typed: true
module Ektar
  # Preview all emails at http://localhost:3000/rails/mailers/user_mailer
  class UserMailerPreview < ActionMailer::Preview
    def invitation_mail
      Ektar::UserMailer.with(user_email: "test@test.com", organization: Ektar::Organization.first, token: "dummy_token").new_invitation_email
    end

    private

    def dummy_user
      User.new(email: "example@mailerPreview.com")
    end
  end
end
