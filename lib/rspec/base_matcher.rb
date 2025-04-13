module RSpec
  class BaseMatcher
    attr_reader :expected

    def initialize(expected = nil)
      @expected = expected
    end
  end

  def self.eq(expected)
    EqualMatcher.new(expected)
  end

  def self.be_empty
    EmptyMatcher.new
  end
end
