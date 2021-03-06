# typed: ignore
# frozen_string_literal: true

module Ektar
  class UsedPassword < ApplicationRecord
    belongs_to :user, class_name: "Ektar::User", foreign_key: :ektar_user_id
    validates :password_digest, presence: true
  end
end
