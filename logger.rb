class Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "Received the incoming request"

    status, headers, body = @app.call(env)

    puts "Received the outgoing response"

    [status, headers, body]
  end
end
