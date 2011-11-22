#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib]))

require 'rubygems'
require 'bundler/setup'

require 'ruby_app/request'

require 'scripts/create_application'

RubyApp::Request.create! do

  require 'rubygems'
  require 'bundler/setup'

  require 'mongo'

  connection = Mongo::Connection.new(Pike::Application.configure.mongoid.host,
                                     Pike::Application.configure.mongoid.port)

  connection.drop_database(Pike::Application.configure.mongoid.database)

end
