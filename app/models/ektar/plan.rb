module Ektar
  class Plan < ApplicationRecord
    has_rich_text :description
  end
end
