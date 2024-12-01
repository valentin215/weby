require 'erb'

# Base controller class for the application
class ApplicationController
  attr_reader :env

  def initialize(env)
    @env = env
  end

  def render(view_template)
    template = File.read(view_template)
    ERB.new(template).result(binding)
  end
end
