# typed: false
require "test_helper"

module Ektar
  class InvitationMailerTest < ActionMailer::TestCase
    test "invite" do
      invitation = ektar_invitations(:pending_invitation)
      host = "https://ektar.io"
      subject = InvitationMailer.with(host: host, token: "3333", invitation: invitation).invite

      assert_emails 1 do
        subject.deliver_now
      end
    end
  end
end
