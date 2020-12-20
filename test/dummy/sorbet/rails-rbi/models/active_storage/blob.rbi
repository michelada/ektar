# This is an autogenerated file for dynamic methods in ActiveStorage::Blob
# Please rerun rake rails_rbi:models[ActiveStorage::Blob] to regenerate.

# typed: strong
module ActiveStorage::Blob::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module ActiveStorage::Blob::GeneratedAttributeMethods
  extend T::Sig

  sig { returns(Integer) }
  def byte_size; end

  sig { params(value: T.any(Integer, Float, ActiveSupport::Duration)).void }
  def byte_size=(value); end

  sig { returns(T::Boolean) }
  def byte_size?; end

  sig { returns(String) }
  def checksum; end

  sig { params(value: T.any(String, Symbol)).void }
  def checksum=(value); end

  sig { returns(T::Boolean) }
  def checksum?; end

  sig { returns(T.nilable(String)) }
  def content_type; end

  sig { params(value: T.nilable(String)).void }
  def content_type=(value); end

  sig { returns(T::Boolean) }
  def content_type?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(DateTime, Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(String) }
  def filename; end

  sig { params(value: T.any(String, Symbol)).void }
  def filename=(value); end

  sig { returns(T::Boolean) }
  def filename?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Integer, Float, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(String) }
  def key; end

  sig { params(value: T.any(String, Symbol)).void }
  def key=(value); end

  sig { returns(T::Boolean) }
  def key?; end

  sig { returns(T.nilable(String)) }
  def metadata; end

  sig { params(value: T.nilable(String)).void }
  def metadata=(value); end

  sig { returns(T::Boolean) }
  def metadata?; end
end

module ActiveStorage::Blob::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[ActiveStorage::Blob]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[ActiveStorage::Blob]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[ActiveStorage::Blob]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(ActiveStorage::Blob)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(ActiveStorage::Blob) }
  def find_by_id!(id); end
end

class ActiveStorage::Blob < ActiveStorage::Record
  include ActiveStorage::Blob::GeneratedAttributeMethods
  include ActiveStorage::Blob::GeneratedAssociationMethods
  extend ActiveStorage::Blob::CustomFinderMethods
  extend T::Sig
  extend T::Generic

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.unattached(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.with_attached_preview_image(*args); end

  sig { returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.unscoped(&block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.select(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.reselect(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.order(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.reorder(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.group(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.limit(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.offset(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.left_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.where(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.rewhere(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.preload(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.extract_associated(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.eager_load(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.includes(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.from(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.lock(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.readonly(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.or(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.having(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.create_with(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.distinct(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.references(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.none(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.unscope(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.merge(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.except(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def self.extending(*args, &block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def self.find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(ActiveStorage::Blob)) }
  def self.find_by(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def self.find_by!(*args); end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.first; end

  sig { returns(ActiveStorage::Blob) }
  def self.first!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.second; end

  sig { returns(ActiveStorage::Blob) }
  def self.second!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.third; end

  sig { returns(ActiveStorage::Blob) }
  def self.third!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.third_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def self.third_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.second_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def self.second_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def self.last; end

  sig { returns(ActiveStorage::Blob) }
  def self.last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def self.exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.one?(*args); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(ActiveStorage::Blob) }
  def self.create(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(ActiveStorage::Blob) }
  def self.create!(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(ActiveStorage::Blob) }
  def self.new(attributes = nil, &block); end
end

class ActiveStorage::Blob::ActiveRecord_Relation < ActiveRecord::Relation
  include ActiveStorage::Blob::ActiveRelation_WhereNot
  include ActiveStorage::Blob::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: ActiveStorage::Blob)

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def unattached(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def with_attached_preview_image(*args); end

  sig { returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_Relation) }
  def extending(*args, &block); end
end

class ActiveStorage::Blob::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include ActiveStorage::Blob::ActiveRelation_WhereNot
  include ActiveStorage::Blob::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: ActiveStorage::Blob)

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unattached(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def with_attached_preview_image(*args); end

  sig { returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(ActiveStorage::Blob)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def find_by!(*args); end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def first; end

  sig { returns(ActiveStorage::Blob) }
  def first!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def second; end

  sig { returns(ActiveStorage::Blob) }
  def second!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def third; end

  sig { returns(ActiveStorage::Blob) }
  def third!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def third_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def third_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def second_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def second_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def last; end

  sig { returns(ActiveStorage::Blob) }
  def last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def one?(*args); end

  sig { override.params(block: T.proc.params(e: ActiveStorage::Blob).void).returns(T::Array[ActiveStorage::Blob]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[ActiveStorage::Blob]) }
  def flatten(level); end

  sig { returns(T::Array[ActiveStorage::Blob]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end
end

class ActiveStorage::Blob::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include ActiveStorage::Blob::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: ActiveStorage::Blob)

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unattached(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def with_attached_preview_image(*args); end

  sig { returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(ActiveStorage::Blob::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(ActiveStorage::Blob)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(ActiveStorage::Blob) }
  def find_by!(*args); end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def first; end

  sig { returns(ActiveStorage::Blob) }
  def first!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def second; end

  sig { returns(ActiveStorage::Blob) }
  def second!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def third; end

  sig { returns(ActiveStorage::Blob) }
  def third!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def third_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def third_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def second_to_last; end

  sig { returns(ActiveStorage::Blob) }
  def second_to_last!; end

  sig { returns(T.nilable(ActiveStorage::Blob)) }
  def last; end

  sig { returns(ActiveStorage::Blob) }
  def last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def one?(*args); end

  sig { override.params(block: T.proc.params(e: ActiveStorage::Blob).void).returns(T::Array[ActiveStorage::Blob]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[ActiveStorage::Blob]) }
  def flatten(level); end

  sig { returns(T::Array[ActiveStorage::Blob]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end

  sig { params(records: T.any(ActiveStorage::Blob, T::Array[ActiveStorage::Blob])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(ActiveStorage::Blob, T::Array[ActiveStorage::Blob])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(ActiveStorage::Blob, T::Array[ActiveStorage::Blob])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(ActiveStorage::Blob, T::Array[ActiveStorage::Blob])).returns(T.self_type) }
  def concat(*records); end
end

module ActiveStorage::Blob::GeneratedAssociationMethods
  extend T::Sig

  sig { returns(::ActiveStorage::Attachment::ActiveRecord_Associations_CollectionProxy) }
  def attachments; end

  sig { params(value: T::Enumerable[::ActiveStorage::Attachment]).void }
  def attachments=(value); end

  sig { returns(T.nilable(::ActiveStorage::Attachment)) }
  def preview_image_attachment; end

  sig { params(value: T.nilable(::ActiveStorage::Attachment)).void }
  def preview_image_attachment=(value); end

  sig { returns(T.nilable(::ActiveStorage::Blob)) }
  def preview_image_blob; end

  sig { params(value: T.nilable(::ActiveStorage::Blob)).void }
  def preview_image_blob=(value); end

  sig { returns(::ActiveStorage::VariantRecord::ActiveRecord_Associations_CollectionProxy) }
  def variant_records; end

  sig { params(value: T::Enumerable[::ActiveStorage::VariantRecord]).void }
  def variant_records=(value); end

  sig { returns(T.nilable(ActiveStorage::Attached::One)) }
  def preview_image; end

  sig { params(attachable: T.untyped).returns(T.untyped) }
  def preview_image=(attachable); end
end
