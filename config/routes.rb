require_relative "../router"

Router.draw do
  get("/") { "Hello Articles !" }

  get("/articles") { "All Articless" }

  get("/articles/1") do |env|
    puts "Path: First World #{env["REQUEST_PATH"]}"
    "First Article"
  end
end