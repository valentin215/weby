module ActiveRecord
  class Relation
    # @param model [Class]
    # e.g. User
    def initialize(model)
      @model = model
      @where_values = []
      @order_values = []
    end

    # @param conditions [Hash]
    # e.g. { name: 'Alice', age: 20 }
    def where(conditions) = tap { @where_values << conditions }

    # @param ordering [String]
    # e.g. 'name ASC'
    def order(ordering) = tap { @order_values << ordering }

    def to_sql
      where_clause = if @where_values.empty?
                       ''
                     else
                       "WHERE #{@where_values.map do |cond|
                         cond.map do |k, v|
                           "#{k} = '#{v}'"
                         end.join(' AND ')
                       end.join(' AND ')}"
                     end

      order_clause = if @order_values.empty?
                       ''
                     else
                       "ORDER BY #{@order_values.map do |cond|
                         cond.map do |k, v|
                           "#{k} #{v.upcase}"
                         end.join(', ')
                       end.join(', ')}"
                     end

      [where_clause, order_clause].reject(&:empty?).join(' ')
    end
  end
end
