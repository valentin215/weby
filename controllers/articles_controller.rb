# Controller for handling Article-related requests
class ArticlesController < ApplicationController
  def index
    @title = 'Rebuild Rails Framework !'
    @tagline = 'A simple repository to understand the foundations of Rails'

    @article = Article.new('My First Article', 'This is the content of my first article')
  end
end
