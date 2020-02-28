# typed: strong
# frozen_string_literal: true

class Ektar::UsedPassword::ActiveRecord_Associations_CollectionProxy
  extend T::Sig

  sig { params(attributes: T::Hash[Symbol, T.untyped]).returns(Ektar::UsedPassword) }
  def create(*attributes); end
end
