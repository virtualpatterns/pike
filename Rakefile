require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'daemons'
require 'fileutils'
require 'rake'
require 'terminal-table'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike/application'
require 'pike/models'
require 'pike/version'

namespace :mongodb do

  desc 'Start MongoDB'
  task :start do |task|
    system("mkdir -p ./process/mongodb/data; mkdir -p ./process/mongodb/log; mongod --dbpath ./process/mongodb/data --logpath ./process/mongodb/log/mongodb.log --verbose --objcheck --fork")
  end

end

namespace :pike do

  desc 'Create console'
  task :console do |task|
    system("clear; bundle exec ruby_app console")
  end

  desc 'Run'
  task :run do |task|
    system("clear; bundle exec ruby_app run")
  end

  desc 'Run w/ coverage report'
  task :coverage => ['pike:cache:create'] do |task|
    system("clear; rm -rf coverage; bundle exec rcov --include $PATH --exclude bin,gems ruby_app -- run; open coverage/index.html")
  end

  desc 'Get version'
  task :version do |task|
    puts Pike::VERSION
  end

  desc 'Push to development and increment version'
  task :push => ['pike:cache:create'] do |task|
    system "git checkout development; git tag -a -m 'Tagging #{Pike::VERSION}' '#{Pike::VERSION}'; git push origin development"
    version_file = File.join(Pike::ROOT, %w[lib pike version.rb])
    Pike::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
    system "sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'"
    system "git commit --all --message='Incrementing version'"
  end

  desc 'Merge development and staging, push staging'
  task :merge do |task|
    system "git checkout staging; git pull origin staging; git merge origin/development; git push origin staging; git checkout development"
  end

  namespace :daemon do

    desc 'Run the daemon'
    task :run do |task|
      run_daemon(['run'])
    end

    desc 'Start the daemon'
    task :start do |task|
      run_daemon(['start'])
    end

    desc 'Stop the daemon'
    task :stop do |task|
      run_daemon(['stop'])
    end

    def run_daemon(arguments)
      pid_path = File.join(File.dirname(__FILE__), %w[process piked pid])
      FileUtils.mkdir_p(pid_path)
      log_path = File.join(File.dirname(__FILE__), %w[process piked log])
      FileUtils.mkdir_p(log_path)
      Daemons.run(File.join(File.dirname(__FILE__), %w[lib pike daemon.rb]),  :app_name   => 'piked',
                                                                              :ARGV       => arguments,
                                                                              :dir_mode   => :normal,
                                                                              :dir        => pid_path,
                                                                              :multiple   => false,
                                                                              :mode       => :load,
                                                                              :backtrace  => true,
                                                                              :monitor    => false,
                                                                              :log_dir    => log_path)
    end

  end

  namespace :data do

    desc 'Dump database'
    task :dump do |task|
      system("rm -f dump.tgz; rm -rf dump; mongodump --db pike --out dump; tar -czf dump.tgz dump; rm -rf dump")
    end

    desc 'Restore a dumped database'
    task :restore => ['data:drop'] do |task|
      system("rm -rf dump; tar -xzf dump.tgz; mongorestore --db pike --verbose --objcheck dump/pike; rm -rf dump")
      Rake::Task['pike:data:migrate:all'].invoke
    end

    desc 'Drop database'
    task :drop do |task|
      Pike::Application.create_default!
      Pike::Application.drop_database!
    end

    namespace :actions do

      desc 'Print all actions'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Actions',
                                    :headings => ['Type',
                                                  'Action',
                                                  'From',
                                                  'To',
                                                  'Created']) do |table|
          Pike::System::Action.all.each do |action|
            table.add_row([action.class,
                           Pike::System::Action::ACTION_NAMES[action.action],
                           action.user_source ? action.user_source.url : nil,
                           action.user_target ? action.user_target.url : nil,
                           action.created_at])
          end
        end
        puts table
      end

    end

    namespace :identities do

      desc 'Print all identities'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Identities',
                                    :headings => ['User',
                                                  'Created',
                                                  'Expires']) do |table|
          Pike::System::Identity.all.each do |identity|
            table.add_row([identity.user.url,
                           identity.created_at,
                           identity.expires])
          end
        end
        puts table
      end

      desc 'Expire all identities'
      task :expire_all do |task|
        Pike::Application.create_default!
        Pike::System::Identity.all.each do |identity|
          identity.expires = Chronic.parse('yesterday')
          identity.save!
        end
      end

    end

    namespace :users do

      desc 'Print all users'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Users',
                                    :headings => ['Id',
                                                  'URL',
                                                  'Created',
                                                  'Updated']) do |table|
          Pike::User.all.each do |user|
            table.add_row([user.id,
                           user.url,
                           user.created_at,
                           user.updated_at])
          end
        end
        puts table
      end

    end

    namespace :projects do

      desc 'Print all projects'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Projects',
                                    :headings => ['User',
                                                  'Id',
                                                  'Name',
                                                  'Shared?',
                                                  'Copy of',
                                                  'Created',
                                                  'Updated']) do |table|
          Pike::Project.all.each do |project|
            table.add_row([project.user.url,
                           project.id,
                           project.name,
                           project.shared?,
                           project.copy_of ? project.copy_of.id : nil,
                           project.created_at,
                           project.updated_at])
          end
        end
        puts table
      end

    end

    namespace :activities do

      desc 'Print all activities'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Activities',
                                    :headings => ['User',
                                                  'Id',
                                                  'Name',
                                                  'Shared?',
                                                  'Copy of',
                                                  'Created',
                                                  'Updated']) do |table|
          Pike::Activity.all.each do |activity|
            table.add_row([activity.user.url,
                           activity.id,
                           activity.name,
                           activity.shared?,
                           activity.copy_of ? activity.copy_of.id : nil,
                           activity.created_at,
                           activity.updated_at])
          end
        end
        puts table
      end

    end

    namespace :tasks do

      desc 'Print all tasks'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Tasks',
                                    :headings => ['User',
                                                  'Project Id',
                                                  'Project',
                                                  'Activity Id',
                                                  'Activity']) do |table|
          Pike::User.all.each do |user|
            user.tasks.all.each do |task|
              table.add_row([task.user.url,
                             task.project_id,
                             task.project ? task.project.name : nil,
                             task.activity_id,
                             task.activity ? task.activity.name : nil])
            end
          end
        end
        puts table
      end

    end

    namespace :migrate do

      desc 'Run all migrations'
      task :all => ['pike:data:migrate:add_user_url',
                    'pike:data:migrate:add_project_name',
                    'pike:data:migrate:add_activity_name',
                    'pike:data:migrate:update_task_project_and_activity_names',
                    'pike:data:migrate:update_user_demo_to_first',
                    'pike:data:migrate:add_friendship_user_target_url',
                    'pike:data:migrate:remove_identities_and_migrations_collections'] do |task|
      end

      desc 'Add the Pike::User#_url property'
      task :add_user_url do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          puts 'Pike::User.all.each do |user| ...'
          Pike::User.all.each do |user|
            puts "  user.url=#{user.url.inspect} user.set(:_url, #{user.url.downcase.inspect})"
            user.set(:_url, user.url.downcase)
          end
          puts '... end'
        end
      end

      desc 'Add the Pike::Project#_name property'
      task :add_project_name do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          puts 'Pike::Project.all.each do |project| ...'
          Pike::Project.all.each do |project|
            puts "  project.name=#{project.name.inspect} project.set(:_name, #{project.name.downcase.inspect})"
            project.set(:_name, project.name.downcase)
          end
          puts '... end'
        end
      end

      desc 'Add the Pike::Activity#_name property'
      task :add_activity_name do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          puts 'Pike::Activity.all.each do |activity| ...'
          Pike::Activity.all.each do |activity|
            puts "  activity.name=#{activity.name.inspect} activity.set(:_name, #{activity.name.downcase.inspect})"
            activity.set(:_name, activity.name.downcase)
          end
          puts '... end'
        end
      end

      desc 'Update the Pike::Task#_project_name and Pike::Task#_activity_name properties'
      task :update_task_project_and_activity_names do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          puts 'Pike::Task.all.each do |_task| ...'
          Pike::Task.all.each do |_task|
            puts "  _task.project.name=#{_task.project ? _task.project.name.inspect : '(nil)'} _task.set(:_project_name, #{_task.project ? _task.project.name.downcase.inspect : '(nil)'})"
            _task.set(:_project_name, _task.project ? _task.project.name.downcase : nil)
            puts "  _task.activity.name=#{_task.activity ? _task.activity.name.inspect : '(nil)'} _task.set(:_activity_name, #{_task.activity ? _task.activity.name.downcase.inspect : '(nil)'})"
            _task.set(:_activity_name, _task.activity ? _task.activity.name.downcase : nil)
          end
          puts '... end'
        end
      end

      desc 'Update the user demo@pike.virtualpatterns.com to first@pike.virtualpatterns.com'
      task :update_user_demo_to_first do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          user = Pike::User.get_user_by_url('demo@pike.virtualpatterns.com', false)
          if user
            puts "  user.url=#{user.url.inspect} user.url = #{'first@pike.virtualpatterns.com'.inspect} user.save!"
            user.url = 'first@pike.virtualpatterns.com'
            user.save!
          end
        end
      end

      desc 'Add the Pike::Friendship#_user_target_url property'
      task :add_friendship_user_target_url do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          puts 'Pike::Friendship.all.each do |friendship| ...'
          Pike::Friendship.all.each do |friendship|
            puts "  friendship.user_target.url=#{friendship.user_target ? friendship.user_target.url.inspect : '(nil)'} friendship.set(:_user_target_url, #{friendship.user_target ? friendship.user_target.url.downcase.inspect : '(nil)'})"
            friendship.set(:_user_target_url, friendship.user_target ? friendship.user_target.url.downcase : nil)
          end
          puts '... end'
        end
      end

      desc 'Remove the identities and migrations collections'
      task :remove_identities_and_migrations_collections do |task|
        Pike::Application.create_default!
        Pike::System::Migration.run(task) do
          database = Mongoid.configure.database
          puts 'database.drop_collection(\'identities\') ...'
          database.drop_collection('identities')
          puts '... done'
          puts 'database.drop_collection(\'migrations\') ...'
          database.drop_collection('migrations')
          puts '... done'
        end
      end

      # Next migration ...
      #   ...

    end

  end

  namespace :test do

    desc 'Run all tests'
    task :all => ['pike:test:specs',
                  'pike:test:features']

    desc 'Run RSpec tests'
    task :specs, :file, :line do |task, arguments|
      if arguments.file
        if arguments.line
          system("bundle exec rspec #{arguments.file} --line_number=#{arguments.line} --format=documentation --colour")
        else
          system("bundle exec rspec #{arguments.file} --format=documentation --colour")
        end
      else
        system("bundle exec rspec spec/ --format=documentation --colour")
      end
    end

    desc 'Run feature tests for all features or the given feature file'
    task :features, :file do |task, arguments|
      unless arguments.file
        system("bundle exec cucumber --format pretty --tags ~@broken --require features")
      else
        system("bundle exec cucumber --format pretty --tags ~@broken --require features '#{arguments.file}'")
      end
    end

  end

  namespace :cache do

    desc 'Create element cache'
    task :create => ['pike:cache:destroy'] do |task|
      Pike::Application.create_cache(File.join(File.dirname(__FILE__), %w[lib pike elements pages]), File.join(File.dirname(__FILE__), %w[lib]))
      system "find . -name '.cache' | xargs git add; git commit --all --message='Updating element cache'"
    end

    desc 'Delete element cache'
    task :destroy do |task|
      Pike::Application.destroy_cache(File.join(File.dirname(__FILE__), %w[lib pike elements]))
    end

  end

end
