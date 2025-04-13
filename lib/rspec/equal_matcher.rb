require_relative 'base_matcher'
module RSpec
  class EqualMatcher < BaseMatcher
    def matches?(actual)
      actual == expected
    end
  end

  class EmptyMatcher < BaseMatcher
    def matches?(actual)
      actual.empty?
    end

    def expected
      'to be empty'
    end
  end
end
