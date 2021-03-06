# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: ignore
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/money-rails/all/money-rails.rbi
#
# money-rails-1.13.3

module MoneyRails
  extend MoneyRails::Configuration
end
module MoneyRails::Configuration
  def add_rate(**, &&); end
  def amount_column; end
  def amount_column=(val); end
  def configure; end
  def currency_column; end
  def currency_column=(val); end
  def default_bank(**, &&); end
  def default_bank=(arg); end
  def default_currency; end
  def default_currency=(currency_name); end
  def default_format; end
  def default_format=(val); end
  def include_validations; end
  def include_validations=(val); end
  def locale_backend(**, &&); end
  def locale_backend=(arg); end
  def no_cents_if_whole; end
  def no_cents_if_whole=(val); end
  def preserve_user_input; end
  def preserve_user_input=(val); end
  def raise_error_on_money_parsing; end
  def raise_error_on_money_parsing=(val); end
  def register_currency=(currency_options); end
  def rounding_mode=(mode); end
  def self.amount_column; end
  def self.amount_column=(val); end
  def self.currency_column; end
  def self.currency_column=(val); end
  def self.default_format; end
  def self.default_format=(val); end
  def self.include_validations; end
  def self.include_validations=(val); end
  def self.no_cents_if_whole; end
  def self.no_cents_if_whole=(val); end
  def self.preserve_user_input; end
  def self.preserve_user_input=(val); end
  def self.raise_error_on_money_parsing; end
  def self.raise_error_on_money_parsing=(val); end
  def self.sign_before_symbol; end
  def self.sign_before_symbol=(val); end
  def self.symbol; end
  def self.symbol=(val); end
  def set_currency_column_for_default_currency!; end
  def sign_before_symbol; end
  def sign_before_symbol=(val); end
  def symbol; end
  def symbol=(val); end
end
class Money
  def self.orig_default_formatting_rules; end
  def to_hash; end
end
class MoneyRails::Hooks
  def self.init; end
end
class MoneyRails::Error < StandardError
end
class MoneyRails::Railtie < Rails::Railtie
end
class MoneyRails::Engine < Rails::Engine
end
module MoneyRails::ActiveModel
end
class MoneyRails::ActiveModel::MoneyValidator < ActiveModel::Validations::NumericalityValidator
  def abs_raw_value; end
  def add_error; end
  def currency; end
  def decimal_mark; end
  def decimal_pieces; end
  def invalid_thousands_separation; end
  def locale_backend; end
  def lookup(key); end
  def normalize_raw_value!; end
  def pieces_array; end
  def record_does_not_have_error?; end
  def reset_memoized_variables!; end
  def symbol; end
  def thousand_separator_after_decimal_mark; end
  def thousands_separator; end
  def validate_each(record, attr, _value); end
  def value_has_too_many_decimal_points; end
end
module MoneyRails::ActiveRecord
end
module MoneyRails::ActiveRecord::Monetizable
  def currency_for(name, instance_currency_name, field_currency_name); end
  def read_monetized(name, subunit_name, options = nil, *args); end
  def write_monetized(name, subunit_name, value, validation_enabled, instance_currency_name, options); end
  extend ActiveSupport::Concern
end
class MoneyRails::ActiveRecord::Monetizable::ReadOnlyCurrencyException < MoneyRails::Error
end
module MoneyRails::ActiveRecord::Monetizable::ClassMethods
  def monetize(*fields); end
  def monetized_attributes; end
  def register_currency(currency_name); end
  def track_monetized_attribute(name, value); end
end
class ActiveSupport::TestCase < Minitest::Test
  include ActiveSupport::CurrentAttributes::TestHelper
end
class ActiveRecord::Base
  extend MoneyRails::ActiveRecord::Monetizable::ClassMethods
  include MoneyRails::ActiveRecord::Monetizable
end
