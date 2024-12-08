require 'logger'
require 'zeitwerk'
require_relative './config/routes'

# Rack application
class App
  attr_reader :logger

  def initialize
    @logger = Logger.new('log/development.log')

    # The push_dir method pushes the directory to the list of root directories
    loader = Zeitwerk::Loader.new
    loader.push_dir('models')
    loader.push_dir('controllers')
    loader.setup
  end

  def call(env)
    logger.info("#{env['REQUEST_METHOD']}: #{env['REQUEST_PATH']}")

    headers = { 'Content-Type' => 'text/html' }

    response_html = router.build_response(env)

    [200, headers, [response_html]]
  rescue StandardError => e
    logger.add(Logger::ERROR, e)

    # we still have to return a rack-compliant response
    [200, headers, ["Error: #{e.message}"]]
  end

  private

  def router = Router.instance
end
