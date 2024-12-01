# Controller for handling Article-related requests

require_relative 'application_controller'
class ArticlesController < ApplicationController
  def index
    '<h1>All Articles</h1>'
  end
end
