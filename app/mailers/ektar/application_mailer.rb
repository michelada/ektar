# typed: false
module Ektar
  class ApplicationMailer < ActionMailer::Base
    default from: "from@example.com"
    layout "ektar/mailer"
  end
end
