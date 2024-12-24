module ActiveRecord
  class Base
    class << self
      attr_reader :relation_delegate_cache

      def inherited(subclass)
        subclass.initialize_relation_delegate_cache
      end

      def self.initialize_relation_delegate_cache
        @relation_delegate_cache = {}
        Delegation::DELEGATED_CLASSES.each do |klass|
          delegate =
            Class.new(klass) do
              include ClassSpecificRelation
            end

          mangled_name = klass.name.gsub('::', '_')
          const_set(mangled_name, delegate)
          private_constant(mangled_name)

          @relation_delegate_cache[klass] = delegate

          current_scope.scope = relation_delegate_cache[Relation].new(self)
        end
      end

      def where(conditions) = current_scope.scope.where(conditions)

      def order(conditions) = current_scope.scope.order(conditions)

      def count
        sql = current_scope.scope.to_sql
        query = "SELECT COUNT(*) FROM #{table_name} #{sql}"
        flush_and_execute(query)
      end

      def to_a
        sql = current_scope.scope.to_sql
        query = "SELECT * FROM #{table_name} #{sql}"
        flush_and_execute(query)
      end

      def table_name = "#{name.downcase}s"

      def current_scope
        @current_scope ||= CurrentScope.new
      end

      def flush_current_scope
        current_scope.scope = relation_delegate_cache[Relation].new(self)
      end

      def flush_and_execute(query)
        puts "Executing SQL: #{query}"
        flush_current_scope
        DatabaseConnection.instance.execute(query)
      end
    end
  end
end
