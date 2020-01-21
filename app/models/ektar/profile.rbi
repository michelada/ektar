# typed: strong

module ActiveStorage::Attached::Model
  extend T::Sig

  sig { params(name: Symbol).returns(ActiveRecord::Reflection) }
  def has_one_attached(name); end
end

class Ektar::Profile < Ektar::ApplicationRecord
  extend ActiveStorage::Attached::Model
end

