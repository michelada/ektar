# typed: ignore

module Ektar
  class Invitation < ApplicationRecord
    extend T::Sig

    belongs_to :organization, class_name: "Ektar::Organization", foreign_key: :ektar_organization_id

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    sig { returns(T::Boolean) }
    def accepted?
      invitation_accepted_at.present?
    end
  end
end
