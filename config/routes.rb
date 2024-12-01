require_relative '../router'

Router.draw do
  get('/') { 'Hello Articles !' }

  get('/articles/index') { 'All Articles' }

  get('/articles/1') do |env|
    puts "Path: First World #{env['REQUEST_PATH']}"
    'First Article'
  end
end
