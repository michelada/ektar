# typed: strict
require "pg_search"

module Ektar
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
