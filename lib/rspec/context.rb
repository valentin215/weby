module RSpec
  class Context
    def initialize(description)
      @description = description
      @lets = {}
      @before_hooks = []
      @after_hooks = []
    end

    def let(name, &block)
      @lets[name] = block

      define_singleton_method(name) do
        @memoized ||= {}
        @memoized[name] ||= instance_eval(&block)
      end
    end

    def before(&block)
      @before_hooks << block
    end

    def after(&block)
      @after_hooks << block
    end

    def run
      # test
      pp('Before hooks', @before_hooks.each { |hook| hook.call }, 'After hooks', @after_hooks.each { |hook| hook.call })
      pp 'Lets', @lets
    end
  end
end
