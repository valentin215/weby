module RSpec
  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to(matcher)
      return if matcher.matches?(@actual)

      raise "Failed - #{matcher.expected.nil? ? 'expected condition not met' : "expected #{matcher.expected}"}, but got #{@actual.inspect}"
    end

    def not_to(matcher)
      return unless matcher.matches?(@actual)

      raise "Failed - #{matcher.expected.nil? ? 'expected condition to fail' : "did not expect #{matcher.expected}"}, but got #{@actual.inspect}"
    end
  end
end
