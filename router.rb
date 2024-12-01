# weby/router.rb

require 'singleton'
require_relative 'controllers/articles_controller'

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
    @routes[path] = (block || lambda { |env|
      controller_name, action_name = find_controller_action(path)   # 'articles', 'index'
      controller_klass = constantize(controller_name)               # ArticlesController
      controller = controller_klass.new(env)                        # ArticlesController.new(env)

      controller.send(action_name.to_sym)                           # controller.index
    })
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || ->(env) { "no route found for #{path}" }
    handler.call(env)
  end

  def find_controller_action(path)
    result = path.match(%r{/(\w+)/(\w+)/?}) # path = '/articles/index'
    controller = result[1]
    action = result[2]
    [controller, action]
  end

  # input: 'articles'
  # output: ArticlesController
  def constantize(name)
    controller_klass_name = "#{name.capitalize}Controller" # "ArticlesController" (a string)
    Object.const_get(controller_klass_name) # ArticlesController (a class)
  end
end
