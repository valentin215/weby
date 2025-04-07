module RSpec
  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to(matcher)
      return if matcher.matches?(@actual)

      raise "Expected #{matcher.expected}, but got #{@actual}"
    end

    def not_to(matcher)
      return unless matcher.matches?(@actual)

      raise "Expected #{matcher.expected}, but got #{@actual}"
    end
  end
end
