# typed: strict

module Ektar
  class Membership < ApplicationRecord
    belongs_to :organization, class_name: "Ektar::Organization", foreign_key: :ektar_organization_id
    belongs_to :user, class_name: "Ektar::User", foreign_key: :ektar_user_id

    accepts_nested_attributes_for :organization

    enum role: {admin: "admin", member: "member"}
  end
end
