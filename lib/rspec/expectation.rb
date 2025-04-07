module RSpec
  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to(matcher)
      return if matcher.match?(@actual)

      raise "Expected #{matcher.expected}, but got #{@actual}"
    end
  end
end
