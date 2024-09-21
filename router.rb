class Router
  def initialize
    @routes = {}
  end
  
  # block is the handler code that will be executed when the route is hit
  def get(path, &block)
    @routes[path] = block
  end
  
  def build_response(path)
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call
  end
end