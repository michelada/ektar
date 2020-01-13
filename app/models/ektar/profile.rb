# typed: false
module Ektar
  class Profile < ApplicationRecord
    belongs_to :user, class_name: "Ektar::User", foreign_key: :ektar_user_id
    has_one_attached :image_profile
    validates :name, presence: true
  end
end
