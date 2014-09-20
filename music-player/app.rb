require "rubygems"
require "bundler"

Bundler.require

get "/" do
  "Hello world!"
end

post "/" do
  binding.pry
end
