# Controller for handling Article-related requests

require_relative 'application_controller'
class ArticlesController < ApplicationController
  def index
    raise 'Stack Overflow!'

    @title = 'Rebuild Rails Framework !'
    @tagline = 'A simple repository to understand the foundations of Rails'
  end
end
