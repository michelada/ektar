# This is an autogenerated file for dynamic methods in Ektar::Membership
# Please rerun bundle exec rake rails_rbi:models[Ektar::Membership] to regenerate.

# typed: strong
module Ektar::Membership::EnumInstanceMethods
  sig { returns(T::Boolean) }
  def admin?; end

  sig { void }
  def admin!; end

  sig { returns(T::Boolean) }
  def member?; end

  sig { void }
  def member!; end
end

module Ektar::Membership::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Ektar::Membership::GeneratedAttributeMethods
  sig { returns(T::Boolean) }
  def active; end

  sig { params(value: T::Boolean).void }
  def active=(value); end

  sig { returns(T::Boolean) }
  def active?; end

  sig { returns(T.nilable(ActiveSupport::TimeWithZone)) }
  def blocked_at; end

  sig { params(value: T.nilable(T.any(Date, Time, ActiveSupport::TimeWithZone))).void }
  def blocked_at=(value); end

  sig { returns(T::Boolean) }
  def blocked_at?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(Integer) }
  def ektar_organization_id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def ektar_organization_id=(value); end

  sig { returns(T::Boolean) }
  def ektar_organization_id?; end

  sig { returns(Integer) }
  def ektar_user_id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def ektar_user_id=(value); end

  sig { returns(T::Boolean) }
  def ektar_user_id?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T::Boolean) }
  def owner; end

  sig { params(value: T::Boolean).void }
  def owner=(value); end

  sig { returns(T::Boolean) }
  def owner?; end

  sig { returns(String) }
  def role; end

  sig { params(value: T.any(Integer, String, Symbol)).void }
  def role=(value); end

  sig { returns(T::Boolean) }
  def role?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module Ektar::Membership::GeneratedAssociationMethods
  sig { returns(::Ektar::Organization) }
  def organization; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::Organization).void)).returns(::Ektar::Organization) }
  def build_organization(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::Organization).void)).returns(::Ektar::Organization) }
  def create_organization(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::Organization).void)).returns(::Ektar::Organization) }
  def create_organization!(*args, &block); end

  sig { params(value: ::Ektar::Organization).void }
  def organization=(value); end

  sig { returns(::Ektar::User) }
  def user; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::User).void)).returns(::Ektar::User) }
  def build_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::User).void)).returns(::Ektar::User) }
  def create_user(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Ektar::User).void)).returns(::Ektar::User) }
  def create_user!(*args, &block); end

  sig { params(value: ::Ektar::User).void }
  def user=(value); end
end

module Ektar::Membership::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Ektar::Membership]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Ektar::Membership]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Ektar::Membership]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(Ektar::Membership)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Ektar::Membership) }
  def find_by_id!(id); end
end

class Ektar::Membership < Ektar::ApplicationRecord
  include Ektar::Membership::EnumInstanceMethods
  include Ektar::Membership::GeneratedAttributeMethods
  include Ektar::Membership::GeneratedAssociationMethods
  extend Ektar::Membership::CustomFinderMethods
  extend Ektar::Membership::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Ektar::Membership::ActiveRecord_Relation, Ektar::Membership::ActiveRecord_Associations_CollectionProxy, Ektar::Membership::ActiveRecord_AssociationRelation) }

  sig { returns(T::Hash[T.any(String, Symbol), String]) }
  def self.roles; end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def self.admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def self.member(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def self.not_admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def self.not_member(*args); end

  sig { returns(Ektar::Membership::Role) }
  def typed_role; end

  sig { params(value: Ektar::Membership::Role).void }
  def typed_role=(value); end

  class Role < T::Enum
    enums do
      Admin = new(%q{admin})
      Member = new(%q{member})
    end

  end
end

class Ektar::Membership::ActiveRecord_Relation < ActiveRecord::Relation
  include Ektar::Membership::ActiveRelation_WhereNot
  include Ektar::Membership::CustomFinderMethods
  include Ektar::Membership::QueryMethodsReturningRelation
  Elem = type_member(fixed: Ektar::Membership)

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def member(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def not_admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def not_member(*args); end
end

class Ektar::Membership::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Ektar::Membership::ActiveRelation_WhereNot
  include Ektar::Membership::CustomFinderMethods
  include Ektar::Membership::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Ektar::Membership)

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def member(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def not_admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def not_member(*args); end
end

class Ektar::Membership::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Ektar::Membership::CustomFinderMethods
  include Ektar::Membership::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Ektar::Membership)

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def member(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def not_admin(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def not_member(*args); end

  sig { params(records: T.any(Ektar::Membership, T::Array[Ektar::Membership])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Ektar::Membership, T::Array[Ektar::Membership])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Ektar::Membership, T::Array[Ektar::Membership])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Ektar::Membership, T::Array[Ektar::Membership])).returns(T.self_type) }
  def concat(*records); end
end

module Ektar::Membership::QueryMethodsReturningRelation
  sig { returns(Ektar::Membership::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Ektar::Membership::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Ektar::Membership::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Ektar::Membership::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Ektar::Membership::QueryMethodsReturningAssociationRelation
  sig { returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Ektar::Membership::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Ektar::Membership::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Ektar::Membership::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end
