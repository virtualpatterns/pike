#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$PIKE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.. ..]))
$LOAD_PATH.unshift $PIKE_ROOT unless $LOAD_PATH.include?($PIKE_ROOT)

require 'scripts/create_application'

Pike::Application.execute do

  require 'scripts/drop_database'
  require 'models'

  require 'scripts/create_projects_and_activities'

  [ 'frank.ficnar@gmail.com',
    'frank.ficnar@mosaic.com' ].each do |url|

    user = Pike::User.get_user(url)

    puts 'Creating tasks ...'

    Pike::Project.where(:user_id => user.id, :name.ne => 'Slack').each do |project|
      Pike::Activity.where(:user_id => user.id, :name.ne => 'Slack').each do |activity|
        task = Pike::Task.create!(:user => user, :project => project, :activity => activity, :flag => Pike::Task::FLAG_NORMAL)
        puts "task.user.url=#{task.user.url.inspect}, task.project.name=#{task.project.name.inspect}, task.activity.name=#{task.activity.name.inspect}, task.flag=#{task.flag.inspect}"
      end
    end

    puts '... done'

    puts 'Listing tasks ...'

    user.tasks.each do |task|
      puts "task.user.url=#{task.user.url}, task.project.name=#{task.project.name}, task.activity.name=#{task.activity.name}, task.flag=#{task.flag.inspect}"
    end

    puts '... done'

  end

end
