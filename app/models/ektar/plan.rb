# typed: false
# frozen_string_literal: true

module Ektar
  class Plan < ApplicationRecord
    extend ActionText::Attribute::ClassMethods
    extend T::Sig

    has_many :organizations, class_name: "Ektar::Organization", foreign_key: "ektar_plan_id"
    has_rich_text :description
    T.unsafe(self).monetize :price_cents

    validates :name, uniqueness: true
    validates_presence_of :name
    validates_presence_of :price_cents
    validates_presence_of :trial
  end
end
