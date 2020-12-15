# typed: ignore
# frozen_string_literal: true

module Ektar
  class Plan < ApplicationRecord
    extend ActionText::Attribute::ClassMethods
    extend T::Sig
    include PgSearch::Model

    has_many :organizations, class_name: "Ektar::Organization", foreign_key: "ektar_plan_id"
    has_rich_text :description
    T.unsafe(self).monetize :price_cents

    validates :name, presence: true, uniqueness: true
    validates :trial, numericality: {only_integer: true, allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 90}
    validates :price, numericality: {greater_than_or_equal_to: 0}

    pg_search_scope :search_full, against: :name,
                                  using: {tsearch: {prefix: true, any_word: true}}
  end
end
