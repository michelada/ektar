# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/activerecord-postgres_enum/all/activerecord-postgres_enum.rbi
#
# activerecord-postgres_enum-0.6.0

module ActiveRecord
end
module ActiveRecord::PostgresEnum
end
module ActiveRecord::PostgresEnum::PostgreSQLAdapter
  def add_enum_value(name, value, after: nil, before: nil); end
  def create_enum(name, values); end
  def drop_enum(name); end
  def enums; end
  def migration_keys; end
  def prepare_column_options(column, types); end
  def rename_enum(name, new_name); end
  def rename_enum_value(name, existing_value, new_value); end
  def rename_enum_value_supported?; end
end
module ActiveRecord::PostgresEnum::PostgreSQLAdapter::SchemaDumperExt
  def prepare_column_options(column); end
end
module ActiveRecord::PostgresEnum::PostgreSQLAdapter::ColumnDumperExt
  def prepare_column_options(column); end
end
module ActiveRecord::PostgresEnum::SchemaDumper
  def dump_enums(stream); end
  def tables(stream); end
end
module ActiveRecord::PostgresEnum::CommandRecorder
  def create_enum(name, values); end
  def invert_create_enum(args); end
  def invert_rename_enum(args); end
  def invert_rename_enum_value(args); end
  def rename_enum(name, new_name); end
  def rename_enum_value(name, existing_value, new_value); end
end
class ActiveRecord::PostgresEnum::EnumValidator < ActiveModel::EachValidator
  def enum_type(object, attribute); end
  def self.enum_values(attr_id, type, connection); end
  def validate_each(object, attribute, value); end
end
module ActiveModel
end
module ActiveModel::Validations
end
module ActiveModel::Validations::HelperMethods
  def validates_enum(*attr_names); end
end
module ActiveRecord::ConnectionAdapters
end
module ActiveRecord::ConnectionAdapters::PostgreSQL
end
module ActiveRecord::ConnectionAdapters::PostgreSQL::OID
end
class ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Enum < ActiveModel::Type::Value
  def enum_name; end
  def initialize(options = nil); end
end
class ActiveRecord::ConnectionAdapters::PostgreSQL::OID::TypeMapInitializer
end
module ActiveRecord::ConnectionAdapters::PostgreSQL::ColumnMethods
  def enum(name, options = nil); end
end
