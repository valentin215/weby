require_relative './router'

class App
  attr_reader :router
  
  def initialize
    @router = Router.new
    
    router.get('/') { "Akshay's Blog" }
    
    router.get('/articles') { 'All Articles' }
    
    router.get('/articles/1') { "First Article" }
  end
  
  def call(env)
    headers = {"Content-Type" => "text/html"}
    
    response_html = router.build_response(env['REQUEST_PATH'])

    [200, headers, [response_html]]
  end
end
