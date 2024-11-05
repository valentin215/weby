# config/routes.rb

require_relative "../router"

Router.draw do
  get("/") { "Hello World !" }

  get("/worlds") { "All Worlds" }

  get("/worlds/1") { "First World" }
end