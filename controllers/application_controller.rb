# Base controller class for the application
class ApplicationController
  attr_reader :env

  def initialize(env)
    @env = env
  end
end
