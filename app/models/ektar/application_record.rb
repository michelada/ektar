# typed: strict
# frozen_string_literal: true

require "pg_search"

module Ektar
  class ApplicationRecord < ActiveRecord::Base
    extend T::Sig

    self.abstract_class = true

    sig { void }
    def debug_caller
      code_caller = caller.select { |c| c.include?("ektar") }[0..1] || []
      Rails.logger.debug "\e[31mDEBUG [#{code_caller[0]&.split(" ")&.last}] #{code_caller[1]}\033[0m"
    end
  end
end
