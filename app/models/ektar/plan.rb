module Ektar
  class Plan < ApplicationRecord
    has_rich_text :description
    monetize :price_cents
  end
end
