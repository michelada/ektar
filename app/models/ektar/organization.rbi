# typed: strong

module PgSearch::Model::ClassMethods
  sig { params(name: Symbol, options: T::Hash[Symbol, T.any]).void }
  def pg_search_scope(name, options); end
end

class Ektar::Organization
  extend PgSearch::Model::ClassMethods
  extend T::Sig

  sig { returns(String) }
  def global_id; end
end
