# typed: false
module Ektar
  class Plan < ApplicationRecord
    has_many :organizations, class_name: "Ektar::Organization", foreign_key: "ektar_plan_id"
    has_rich_text :description
    monetize :price_cents
  end
end
