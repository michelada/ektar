# typed: true

module Ektar
  class Membership < ApplicationRecord
    belongs_to :ektar_organization, class_name: "Ektar::Organization", foreign_key: :ektar_organization_id
    belongs_to :ektar_user, class_name: "Ektar::User", foreign_key: :ektar_user_id
  end
end
