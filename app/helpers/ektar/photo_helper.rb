# typed: strong
# frozen_string_literal: true
module Ektar
  module PhotoHelper
    SIZE_FACTOR = 2

    def photo_url(model, field: :image, height: 480, width: 360, no_factor: false, custom: {gravity: "center"})
      image = model.send(field)
      return "" unless image&.attached?

      size = no_factor ? [width, height] : [width * SIZE_FACTOR, height * SIZE_FACTOR]
      variant = image.variant(resize_to_fit: size, quality: 100, **custom).processed

      url_for(variant)
    end
  end
end
