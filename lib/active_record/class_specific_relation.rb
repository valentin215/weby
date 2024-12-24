module ActiveRecord
  module ClassSpecificRelation
    def method_missing(method, *args, &block)
      if @model.respond_to?(method)
        self.class.define_method(method) do |*args, &block|
          @model.public_send(method, *args, &block)
        end

        public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      @model.respond_to?(method) || super
    end
  end
end
