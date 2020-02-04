# typed: strong

class ActiveRecord::Base
  extend T::Sig

  sig do
    params(
      name: Symbol,
      presence: T.nilable(T::Boolean),
      inclusion: T::Array[T.any(String, Symbol)],
      uniqueness: T.any(T::Boolean, T::Hash[Symbol, T.untyped]),
      format: T::Hash[Symbol, T.untyped]
    ).void
  end

  def self.validates(
    name,
    presence: nil,
    inclusion: nil,
    uniqueness: nil,
    format: nil
  )
  end
end
