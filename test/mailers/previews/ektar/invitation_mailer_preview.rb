# typed: true

module Ektar
  # Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
  class InvitationMailerPreview < ActionMailer::Preview
    def invite
      Ektar::InvitationMailer.with(host: "https://ektar.io", invitation: invitation).invite
    end

    private

    def invitation
      Ektar::Invitation.new(
        invitation_token: "123334",
        email: "preview@example.org",
        organization: Ektar::Organization.new(name: "Preview organization")
      )
    end
  end
end
