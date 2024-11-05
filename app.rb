require_relative './router'

class App
  attr_reader :router
  
  def initialize
    @router = Router.new
    
    router.get('/') { "Hello World !" }
    
    router.get('/worlds') { 'All Worlds' }
    
    router.get('/worlds/1') { "First World" }
  end
  
  def call(env)
    headers = {"Content-Type" => "text/html"}
    
    response_html = router.build_response(env['REQUEST_PATH'])

    [200, headers, [response_html]]
  end
end
