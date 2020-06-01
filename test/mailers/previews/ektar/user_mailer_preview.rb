# typed: false

module Ektar
  # Preview all emails at http://localhost:3000/rails/mailers/user_mailer
  class UserMailerPreview < ActionMailer::Preview
    def invitation_mail
      invitation = T.must(Ektar::Invitation.last)
      organization = Ektar::Organization.find_by(id: invitation.ektar_organization_id)

      Ektar::UserMailer.with(email: invitation.email, organization: organization, invitation_token: invitation.invitation_token).new_invitation_email
    end

    private

    def dummy_user
      User.new(email: "example@mailerPreview.com")
    end
  end
end
