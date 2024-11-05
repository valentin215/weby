# weby/router.rb

require "singleton"

class Router
  include Singleton

  attr_reader :routes

  class << self
    def draw(&block)
      Router.instance.instance_exec(&block)
    end
  end

  def initialize
    @routes = {}
  end

  # block is the handler code that will be executed when the route is hit
  def get(path, &block)
    @routes[path] = block
  end
  
  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || ->(env) { "no route found for #{path}" }
    handler.call(env)
  end
end