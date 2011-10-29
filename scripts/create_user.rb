#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib]))

require 'scripts/create_application'

Pike::Application.execute do

  require 'scripts/drop_database'
  require 'pike/models'

  user = Pike::User.get_user('frank.ficnar@gmail.com')

  puts 'Listing tasks ...'

  user.tasks.each do |task|
    puts "task.user.url=#{task.user.url}, task.project.name=#{task.project.name}, task.activity.name=#{task.activity.name}, task.flag=#{task.flag.inspect}"
  end

  puts '... done'

end
