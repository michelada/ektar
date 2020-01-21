# typed: strict
module Ektar
  class Plan < ApplicationRecord
    extend ActionText::Attribute::ClassMethods
    extend T::Sig

    has_many :organizations, class_name: "Ektar::Organization", foreign_key: "ektar_plan_id"
    has_rich_text :description
    T.unsafe(self).monetize :price_cents

    validates :name, uniqueness: true
    validates :name, :price_cents, :trial, presence: true
  end
end
