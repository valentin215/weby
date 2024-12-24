class Relation
  # @param model [Class]
  # e.g. User
  def initialize(model)
    @model = model
    @where_values = []
  end

  # @param conditions [Hash]
  # e.g. { name: 'Alice', age: 20 }
  def where(conditions) = tap { @where_values << conditions }

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

    [where_clause].reject(&:empty?).join(' ')
  end
end
