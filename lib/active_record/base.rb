module ActiveRecord
  class Base
    class << self
      attr_reader :relation_delegate_cache

      def inherited(subclass)
        subclass.initialize_relation_delegate_cache
      end

      def initialize_relation_delegate_cache
        @relation_delegate_cache = {}
        Delegation::DELEGATED_METHODS.each do |klass|
          delegate = delegate_klass(klass)
          current_scope(klass, delegate)
        end
      end

      def delegate_klass(klass)
        Class.new(klass) do
          include ClassSpecificRelation
        end
      end

      def current_scope(klass, delegate)
        mangled_name = klass.name.gsub('::', '_')
        const_set(mangled_name, delegate)
        private_constant(mangled_name)
        @relation_delegate_cache[klass] = delegate
        current_scope.scope = relation_delegate_cache[Relation].new(self)
      end
    end
  end
end
