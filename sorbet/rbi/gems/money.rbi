# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/money/all/money.rbi
#
# money-6.13.7

class Money
  def allocate(parts); end
  def amount; end
  def as_ca_dollar; end
  def as_d(num); end
  def as_euro; end
  def as_us_dollar; end
  def bank; end
  def cents; end
  def currency; end
  def currency_as_string; end
  def currency_as_string=(val); end
  def decimal_mark; end
  def dollars; end
  def exchange_to(other_currency, &rounding_method); end
  def format(*rules); end
  def fractional; end
  def hash; end
  def initialize(obj, currency = nil, bank = nil); end
  def inspect; end
  def locale_backend; end
  def return_value(value); end
  def round(rounding_mode = nil, rounding_precision = nil); end
  def round_to_nearest_cash_value; end
  def self.add_rate(from_currency, to_currency, rate); end
  def self.conversion_precision; end
  def self.conversion_precision=(arg0); end
  def self.default_bank; end
  def self.default_bank=(arg0); end
  def self.default_currency; end
  def self.default_currency=(currency); end
  def self.default_formatting_rules; end
  def self.default_formatting_rules=(arg0); end
  def self.disallow_currency_conversion!; end
  def self.from_amount(amount, currency = nil, bank = nil); end
  def self.infinite_precision; end
  def self.infinite_precision=(arg0); end
  def self.inherited(base); end
  def self.locale_backend; end
  def self.locale_backend=(value); end
  def self.rounding_mode(mode = nil); end
  def self.rounding_mode=(new_rounding_mode); end
  def self.setup_defaults; end
  def self.use_i18n; end
  def self.use_i18n=(value); end
  def self.with_rounding_mode(mode); end
  def split(parts); end
  def symbol; end
  def thousands_separator; end
  def to_d; end
  def to_f; end
  def to_i; end
  def to_money(given_currency = nil); end
  def to_s; end
  def with_currency(new_currency); end
  extend Money::Constructors
  include Comparable
  include Money::Arithmetic
end
class Money::Currency
  def <=>(other_currency); end
  def ==(other_currency); end
  def code; end
  def compare_ids(other_currency); end
  def decimal_mark; end
  def decimal_places; end
  def delimiter; end
  def disambiguate_symbol; end
  def eql?(arg0); end
  def exponent; end
  def hash; end
  def html_entity; end
  def id; end
  def initialize(id); end
  def initialize_data!; end
  def inspect; end
  def iso?; end
  def iso_code; end
  def iso_numeric; end
  def name; end
  def priority; end
  def self._instances; end
  def self.all; end
  def self.each; end
  def self.find(id); end
  def self.find_by_iso_numeric(num); end
  def self.inherit(parent_iso_code, curr); end
  def self.new(id); end
  def self.register(curr); end
  def self.stringified_keys; end
  def self.stringify_keys; end
  def self.table; end
  def self.unregister(curr); end
  def self.wrap(object); end
  def separator; end
  def smallest_denomination; end
  def subunit; end
  def subunit_to_unit; end
  def symbol; end
  def symbol_first; end
  def symbol_first?; end
  def thousands_separator; end
  def to_currency; end
  def to_s; end
  def to_str; end
  def to_sym; end
  extend Enumerable
  extend Money::Currency::Heuristics
  include Comparable
end
module Money::Currency::Loader
  def self.load_currencies; end
  def self.parse_currency_file(filename); end
end
module Money::Currency::Heuristics
  def analyze(str); end
end
class Money::Currency::MissingAttributeError < StandardError
  def initialize(method, currency, attribute); end
end
class Money::Currency::UnknownCurrency < ArgumentError
end
module Money::Bank
end
class Money::Bank::Error < StandardError
end
class Money::Bank::UnknownRate < Money::Bank::Error
end
class Money::Bank::Base
  def exchange_with(from, to_currency, &block); end
  def initialize(&block); end
  def rounding_method; end
  def same_currency?(currency1, currency2); end
  def self.instance; end
  def setup; end
end
module Money::RatesStore
end
class Money::RatesStore::Memory
  def add_rate(currency_iso_from, currency_iso_to, rate); end
  def each_rate(&block); end
  def get_rate(currency_iso_from, currency_iso_to); end
  def guard; end
  def initialize(opts = nil, rates = nil); end
  def marshal_dump; end
  def options; end
  def rate_key_for(currency_iso_from, currency_iso_to); end
  def rates; end
  def transaction(&block); end
end
class Money::Bank::UnknownRateFormat < StandardError
end
class Money::Bank::VariableExchange < Money::Bank::Base
  def add_rate(from, to, rate); end
  def calculate_fractional(from, to_currency); end
  def exchange(fractional, rate, &block); end
  def exchange_with(from, to_currency, &block); end
  def export_rates(format, file = nil, opts = nil); end
  def get_rate(from, to, opts = nil); end
  def import_rates(format, s, opts = nil); end
  def initialize(st = nil, &block); end
  def marshal_dump; end
  def marshal_load(arr); end
  def mutex; end
  def rates; end
  def set_rate(from, to, rate, opts = nil); end
  def store; end
end
class Money::Bank::DifferentCurrencyError < Money::Bank::Error
end
class Money::Bank::SingleCurrency < Money::Bank::Base
  def exchange_with(from, to_currency, &block); end
end
module Money::Arithmetic
  def %(val); end
  def *(value); end
  def +(other); end
  def -(other); end
  def -@; end
  def /(value); end
  def <=>(other); end
  def ==(other); end
  def abs; end
  def coerce(other); end
  def div(value); end
  def divmod(val); end
  def divmod_money(val); end
  def divmod_other(val); end
  def eql?(other_money); end
  def modulo(val); end
  def negative?; end
  def nonzero?; end
  def positive?; end
  def remainder(val); end
  def zero?; end
end
class Money::Arithmetic::CoercedNumeric < Struct
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
  def value; end
  def value=(_); end
  def zero?; end
end
module Money::Constructors
  def ca_dollar(cents); end
  def cad(cents); end
  def empty(currency = nil); end
  def eur(cents); end
  def euro(cents); end
  def gbp(pence); end
  def pound_sterling(pence); end
  def us_dollar(cents); end
  def usd(cents); end
  def zero(currency = nil); end
end
class Money::FormattingRules
  def [](key); end
  def currency; end
  def default_formatting_rules; end
  def determine_format_from_formatting_rules(rules); end
  def has_key?(key); end
  def initialize(currency, *raw_rules); end
  def localize_formatting_rules(rules); end
  def normalize_formatting_rules(rules); end
  def symbol_position_from(rules); end
  def translate_formatting_rules(rules); end
  def warn_about_deprecated_rules(rules); end
end
class Money::Formatter
  def append_currency_symbol(formatted_number); end
  def append_sign(formatted_number); end
  def currency; end
  def decimal_mark; end
  def delimiter; end
  def extract_whole_and_decimal_parts; end
  def format_decimal_part(value); end
  def format_number; end
  def format_whole_part(value); end
  def free_text; end
  def html_wrap(string, class_name); end
  def initialize(money, *rules); end
  def lookup(key); end
  def money; end
  def regexp_format; end
  def rules; end
  def separator; end
  def show_free_text?; end
  def symbol_value_from(rules); end
  def thousands_separator; end
  def to_s; end
end
class Money::Allocation
  def self.generate(amount, parts, whole_amounts = nil); end
end
module Money::LocaleBackend
  def self.find(name); end
end
class Money::LocaleBackend::NotSupported < StandardError
end
class Money::LocaleBackend::Unknown < ArgumentError
end
class Money::LocaleBackend::Base
end
class Money::LocaleBackend::I18n < Money::LocaleBackend::Base
  def initialize; end
  def lookup(key, _); end
end
class Money::LocaleBackend::Legacy < Money::LocaleBackend::Base
  def i18n_backend; end
  def initialize; end
  def lookup(key, currency); end
end
class Money::LocaleBackend::Currency < Money::LocaleBackend::Base
  def lookup(key, currency); end
end
class Money::UndefinedSmallestDenomination < StandardError
end
