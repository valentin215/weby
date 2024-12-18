# middleware/logging.rb
# This middleware logs the request and response

require 'logger'

module Middleware
  class Logging
    attr_reader :logger

    def initialize(app)
      @app = app
      @logger = Logger.new('log/development.log')
    end

    def call(env)
      logger.info("Request: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}")
      @app.call(env)
    rescue StandardError => e
      logger.error("Oops, something went wrong: #{e.message}")
      [400, { 'Content-Type' => 'text/html' }, ["Error: #{e.message}"]]
    end
  end
end
