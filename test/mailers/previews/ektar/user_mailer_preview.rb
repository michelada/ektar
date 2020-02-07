module Ektar
  # Preview all emails at http://localhost:3000/rails/mailers/user_mailer
  class UserMailerPreview < ActionMailer::Preview
    def invitation_mail
      Ektar::UserMailer.with(user: dummy_user, current_user: dummy_user).new_invitation_email
    end

    private

    def dummy_user
      User.new(email: "example@mailerPreview.com")
    end
  end
end
