# typed: true
# frozen_string_literal: true

require "active_support/concern"

module Ektar
  module Concerns
    module Tokens
      extend ActiveSupport::Concern
      extend T::Sig

      included do
        sig { params(data: String, expires_in: T.nilable(ActiveSupport::Duration)).returns(String) }
        def generate_invitation_token(data, expires_in: 7.days)
          generate_token(data, expires_in: expires_in, purpose: :invitation)
        end

        sig { params(data: String).returns(T.nilable(String)) }
        def verify_invitation_token_from_url(data)
          verify_url_token(data, purpose: :invitation)
        end

        sig { params(data: String, expires_in: T.nilable(ActiveSupport::Duration)).returns(String) }
        def generate_reset_password_token(data, expires_in: 1.days)
          generate_token(data, expires_in: expires_in, purpose: :reset_password)
        end

        sig { params(data: T.nilable(String)).returns(T.nilable(String)) }
        def verify_reset_password_token_from_url(data)
          return nil if data.blank?
          verify_url_token(data, purpose: :reset_password)
        end

        sig { params(token: String).returns(String) }
        def token_to_url(token)
          CGI.escape(token)
        end

        sig { params(token: String).returns(String) }
        def token_from_url(token)
          CGI.unescape(token)
        end

        private

        sig { params(data: String, purpose: T.nilable(Symbol)).returns(T.nilable(String)) }
        def verify_url_token(data, purpose: nil)
          secret_key = Ektar.configuration.secret_key || Rails.application.secret_key_base
          verifier = ActiveSupport::MessageVerifier.new(secret_key)

          token = token_from_url(data)
          verifier.verified(token, purpose: purpose)
        end

        sig { params(data: String, expires_in: T.nilable(ActiveSupport::Duration), purpose: T.nilable(Symbol)).returns(String) }
        def generate_token(data, expires_in: 1.day, purpose: nil)
          secret_key = Ektar.configuration.secret_key || Rails.application.secret_key_base
          verifier = ActiveSupport::MessageVerifier.new(secret_key)
          verifier.generate(data, expires_in: expires_in, purpose: purpose)
        end
      end
    end
  end
end
