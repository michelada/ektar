# typed: strong

class Ektar::Membership::ActiveRecord_Associations_CollectionProxy
  extend T::Sig
  sig {params(attributes: T::Hash[Symbol, String], block: T.untyped).returns(Ektar::Membership)}
  def build(attributes = {}, &block)
  end

  def empty?
  end
end

class Ektar::Membership
  sig {params(attributes: T::Hash[Symbol, String], block: T.untyped).returns(Ektar::Organization)}
  def build_organization(attributes = {}, &block)
  end
end

module ActionDispatch::Cookies::ChainedCookieJars
  def cookies
  end
end

module Ektar
  class UsersController < ResourcefulController
    include ActionDispatch::Cookies::ChainedCookieJars
  end
end

class ActionController::Parameters
  def first
  end
end
