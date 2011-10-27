#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$PIKE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.. ..]))
$LOAD_PATH.unshift $PIKE_ROOT unless $LOAD_PATH.include?($PIKE_ROOT)

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
