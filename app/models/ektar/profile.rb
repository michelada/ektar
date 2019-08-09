module Ektar
  class Profile < ApplicationRecord
    belongs_to :ektar_user
    has_one_attached :image_profile
  end
end
