#!/usr/bin/env ruby
require_relative '../../lib/rspec'

if ARGV.empty?
  Dir['./spec/**/*_spec.rb'].each { |file| load file }
else
  ARGV.each { |file| load file }
end

# How to run it ?
# From the root of the project
# chmod +x rspec/bin/rspec.rb
# cd rspec
# ./bin/rspec.rb
