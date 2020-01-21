# typed: strong

class Ektar::User < Ektar::ApplicationRecord
  extend T::Sig

  sig { returns(String) }
  def global_id; end

  sig { params(value: String).void }
  def global_id=(value); end
end
