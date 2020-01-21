# typed: strong

module MoneyRails::ActiveRecord::Monetizable::ClassMethods
  extend T::Sig
  
  sig { params(fields: Symbol).void }
  def monetize(*fields); end  
end

module ActionText::Attribute::ClassMethods
  extend T::Sig
  
  sig { params(name: Symbol).void }
  def has_rich_text(name); end
end
