require 'zeitwerk'
require_relative './config/routes'

# Rack application
class App
  def initialize
    # The push_dir method pushes the directory to the list of root directories
    loader = Zeitwerk::Loader.new
    loader.push_dir('models')
    loader.push_dir('controllers')
    loader.setup
  end

  def call(env)
    headers = { 'Content-Type' => 'text/html' }

    response_html = router.build_response(env)

    [200, headers, [response_html]]
  end

  private

  def router = Router.instance
end
