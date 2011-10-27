#!/usr/bin/env ruby
puts "Running #{__FILE__.inspect}"

$PIKE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.. ..]))
$LOAD_PATH.unshift $PIKE_ROOT unless $LOAD_PATH.include?($PIKE_ROOT)

require 'scripts/create_application'

Pike::Application.execute do

  require 'scripts/drop_database'
  require 'pike/models'

  [ 'frank.ficnar@gmail.com',
    'frank.ficnar@mosaic.com' ].each do |url|

    user = Pike::User.get_user(url)

    puts 'Creating projects ...'

    ['Finance', 'Payroll', 'Office Management'].each do |name|
      project = Pike::Project.create!(:user => user, :name => name)
      puts "project.user.url=#{project.user.url.inspect}, project.name=#{project.name.inspect}"
    end

    puts '... done'

    puts 'Creating activities ...'

    ['Analysis', 'Design', 'Development', 'Maintenance'].each do |name|
      activity = Pike::Activity.create!(:user => user, :name => name)
      puts "activity.user.url=#{activity.user.url.inspect}, activity.name=#{activity.name.inspect}"
    end

    puts '... done'

  end

end
