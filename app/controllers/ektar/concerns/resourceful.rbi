# typed: strong

module ActiveSupport::Concern

 sig { params( base: T.nilable( String ), blk: T.proc.void ).void }
 def included( base = nil, &blk); end

 sig { params( meths: String ).void }
 def helper_method(*meths); end

 sig { params( model_name: Symbol, actions: String ).void }
 def resourceful(model_name, *actions); end
end
