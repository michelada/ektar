# typed: true
module Ektar
  class ApplicationMailer < ActionMailer::Base
    before_action :url_options

    default from: I18n.t("mailers.default_from")
    layout "ektar/mailer"
    extend T::Sig

    private

    sig { void }
    def url_options
      @url_options = {}
      host = params.delete(:host)
      @url_options[:host] = host if host.present?
    end
  end
end
