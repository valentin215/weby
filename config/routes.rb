require_relative '../router'

Router.draw do
  get('/') { 'Hello Articles !' }
  get('/articles/index')
end
