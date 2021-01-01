# typed: ignore
# frozen_string_literal: true

require "test_helper"

module Ektar
  class ResetPasswordMailerTest < ActionMailer::TestCase
    test "reset" do
      user = ektar_users(:user)
      user.update(reset_password_token: "8383833")
      host = "https://ektar.io"

      subject = ResetPasswordMailer.with(host: host, user: user).reset

      assert_emails 1 do
        subject.deliver_now
      end
    end
  end
end
