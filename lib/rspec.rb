require_relative 'rspec/context'
require_relative 'rspec/expectation'
require_relative 'rspec/equal_matcher'
require_relative 'rspec/base_matcher'

module RSpec
  def self.describe(description, &block)
    context = Context.new(description)
    context.instance_eval(&block)

    context.run
  end

  def self.expect(actual)
    Expectation.new(actual)
  end
end
