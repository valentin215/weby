require_relative "../router"

Router.draw do
  get("/") { "Hello World !" }

  get("/worlds") { "All Worlds" }

  get("/worlds/1") do |env|
    puts "Path: First World #{env["REQUEST_PATH"]}"
    "First World"
  end
end