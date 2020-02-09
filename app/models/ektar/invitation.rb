# typed: true

module Ektar
  class Invitation < ApplicationRecord
    extend T::Sig

    belongs_to :organization, class_name: "Ektar::Organization", foreign_key: :ektar_organization_id

    sig { returns(T::Boolean) }
    def accepted?
      invitation_accepted_at.present?
    end
  end
end
