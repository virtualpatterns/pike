require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'daemons'
require 'rake'
require 'terminal-table'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike/application'
require 'pike/models'
require 'pike/version'

namespace :mongo do

  desc 'Run MongoDB'
  task :run do |task|
    system("clear; bundle exec mongod run --rest --quiet --config #{File.join(File.dirname(__FILE__), %w[mongod.conf])}")
  end

end

namespace :pike do

  desc 'Create console'
  task :console do |task|
    system("clear; bundle exec ruby_app console")
  end

  desc 'Run'
  task :run => ['pike:cache:create',
                'pike:daemon:restart'] do |task|
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

    desc 'Restart the daemon'
    task :restart => ['pike:daemon:stop',
                      'pike:daemon:start'] do
    end

    def run_daemon(arguments)
      pid_path = File.join(File.dirname(__FILE__), 'pid')
      Dir.mkdir(pid_path) unless File.exists?(pid_path)
      Daemons.run(File.join(File.dirname(__FILE__), %w[lib pike daemon.rb]),  :app_name   => 'piked',
                                                                              :ARGV       => arguments,
                                                                              :dir_mode   => :normal,
                                                                              :dir        => pid_path,
                                                                              :multiple   => false,
                                                                              :mode       => :load,
                                                                              :backtrace  => true,
                                                                              :monitor    => false)
    end

  end

  namespace :data do

    desc 'Dump database'
    task :dump do |task|
      system("rm -rf dump; bundle exec mongodump --db pike --out dump; tar -czf dump.tgz dump; rm -rf dump")
    end

    desc 'Restore a dumped database'
    task :restore => ['data:drop'] do |task|
      system("rm -rf dump; tar -xzf dump.tgz; bundle exec mongorestore --db pike --drop dump/pike;  rm -rf dump")
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
        table = Terminal::Table.new(:title => 'Users',
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

    namespace :tasks do

      desc 'Print all tasks'
      task :print_all do |task|
        Pike::Application.create_default!
        table = Terminal::Table.new(:title => 'Tasks',
                                    :headings => ['User',
                                                  'Project',
                                                  'Activity']) do |table|
          Pike::User.all.each do |user|
            user.tasks.all.each do |task|
              table.add_row([task.user.url,
                             task.project.name,
                             task.activity.name])
            end
          end
        end
        puts table
      end

    end

    namespace :migrate do

      desc 'Run all migrations'
      task :all => ['migrate:add_user_url',
                    'migrate:add_project_name',
                    'migrate:add_activity_name',
                    'migrate:update_task_project_and_activity_names',
                    'migrate:update_user_demo_to_first'] do |task|
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

      # Next migration ...
      #   Delete collections identities, migrations (have been prefixed with system_)
      #   ...

    end

  end

  namespace :test do

    desc 'Run all tests'
    task :all => ['test:specs',
                  'test:features']

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
      system "git commit --all --message='Deleting element cache'"
    end

  end

end
