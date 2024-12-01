# Controller for handling Article-related requests

require_relative 'application_controller'
class ArticlesController < ApplicationController
  def index
    index_file = File.join(Dir.pwd, 'views', 'index.html')
    File.read(index_file)
  end
end
