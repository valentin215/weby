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
  end

  class BaseMatcher
    attr_reader :expected

    def initialize(expected)
      @expected = expected
    end
  end

  def self.eq(expected)
    EqualMatcher.new(expected)
  end

  def self.be_empty(expected)
    EmptyMatcher.new(expected)
  end
end
