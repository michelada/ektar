# typed: strong

class ActiveRecord::Base
  extend T::Sig

  # sig do
  #   params(
  #     name: Symbol,
  #     presence: T.nilable(T::Boolean),
  #     inclusion: T::Array[T.any(String, Symbol)],
  #     uniqueness: T.any(T::Boolean, T::Hash[Symbol, T.untyped]),
  #     format: T::Hash[Symbol, T.untyped]
  #   ).void
  # end

  sig { params(attributes: T.any(Symbol, T::Hash[Symbol, T.untyped])).void }
  def self.validates(*attributes)
  end

  sig { params(attributes: T.any(Symbol, T::Hash[Symbol, T.untyped])).void }
  def self.validate(*attributes)
  end

  sig { params(name: Symbol, body: T.proc.void).void }
  def self.scope(name, body, &block)
  end
end
