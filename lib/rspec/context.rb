module RSpec
  class Context
    def initialize(description)
      @description = description
      @lets = {}
      @before_hooks = []
      @after_hooks = []
      @tests = []
      @matchers = { eq: EqualMatcher, be_empty: EmptyMatcher }
    end

    def let(name, &block)
      @lets[name] = block

      define_singleton_method(name) do
        @memoized ||= {}
        @memoized[name] ||= instance_eval(&@lets[name])
      end
    end

    def before(&block)
      @before_hooks << block
    end

    def after(&block)
      @after_hooks << block
    end

    def it(description, &block)
      @tests << { description: description, block: block }
    end

    def run
      puts "Running #{@description}"

      @tests.each do |test|
        @memoized = nil

        @before_hooks.each { |hook| instance_eval(&hook) }

        begin
          instance_eval(&test[:block])

          puts "#{test[:description]}: Passed"
        rescue StandardError => e
          puts "#{test[:description]}: Failed - #{e.message}"
        end

        @after_hooks.each { |hook| instance_eval(&hook) }
      end
    end

    def expect(actual)
      RSpec.expect(actual)
    end

    def method_missing(method_name, *args, &block)
      matcher_class = @matchers[method_name]
      return super if matcher_class.nil?

      matcher_class.new(*args)
    end

    def respond_to_missing?(method_name, include_private = false)
      @matchers.key?(method_name) || super
    end
  end
end
