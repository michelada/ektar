module Ektar
  class DummyResponder
    # rubocop:disable Style/MethodMissingSuper
    def method_missing(args) # :nodoc:
      nil
    end
    # rubocop:enable Style/MethodMissingSuper

    def respond_to_missing?(name, include_private) # :nodoc:
      true
    end
  end
end
