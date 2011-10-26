#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$PIKE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.. ..]))
$LOAD_PATH.unshift $PIKE_ROOT unless $LOAD_PATH.include?($PIKE_ROOT)

require 'scripts/create_application'

Pike::Application.execute do

  require 'rubygems'
  require 'bundler/setup'

  require 'mongo'

  connection = Mongo::Connection.new(Pike::Application.configuration.mongoid.host,
                                     Pike::Application.configuration.mongoid.port)

  connection.drop_database(Pike::Application.configuration.mongoid.database)

end
