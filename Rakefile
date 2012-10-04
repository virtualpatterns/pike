require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'daemons'
require 'fileutils'
require 'rake'
require 'terminal-table'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike'
require 'pike/models'

namespace :pike do

  desc 'Print version information from Pike::VERSION'
  task :version do |task|
    puts Pike::VERSION
  end

  desc 'Pull development, tag, push to development, and increment version'
  task :push do |task|
    system("git checkout development; git pull origin development; git tag -a -m 'Tagging #{Pike::VERSION}' '#{Pike::VERSION}'; git push --tags origin development")
    version_file = File.join(Pike::ROOT, %w[lib pike version.rb])
    Pike::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
    system("sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'")
    system("git commit --all --message='Version #{Pike::VERSION}'")
  end

  namespace :merge do

    desc 'Merge development and staging, push staging'
    task :staging do |task|
      system('git checkout staging; git pull origin staging; git merge origin/development; git push --tags origin staging; git checkout development')
    end

    desc 'Merge staging and production, push production'
    task :production do |task|
      system('git checkout production; git pull origin production; git merge origin/staging; git push --tags origin production; git checkout development')
    end

  end

  namespace :process do

    desc 'Create a console'
    task :console do |task|
      system('clear; bundle exec ruby_app console')
    end

    namespace :mongodb do

      desc 'Start MongoDB'
      task :start do |task|
        system('mkdir -p ./process/mongodb/data; mkdir -p ./process/mongodb/log; mongod --dbpath ./process/mongodb/data --logpath ./process/mongodb/log/mongodb.log --verbose --objcheck --fork')
      end

    end

    namespace :daemon do

      desc 'Start the daemon'
      task :start do |task|
        run_daemon(['start'])
      end

      desc 'Stop the daemon'
      task :stop do |task|
        run_daemon(['stop'])
      end

      desc 'Restart the daemon'
      task :restart => ['pike:process:daemon:stop',
                        'pike:process:daemon:start']

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

    namespace :thin do

      desc 'Start the server(s)'
      task :start, :daemonize, :servers do |task, arguments|
        daemonize = arguments.daemonize ? arguments.daemonize.to_b : true
        servers = arguments.servers ? arguments.servers.to_i : 1
        system("#{servers == 1 ? 'rm -f ./process/thin/pid/thin.pid' : 'rm -f ./process/thin/pid/thin.*.pid'}; #{daemonize ? nil : 'clear; '} bundle exec thin --port 8000 #{servers > 1 ? "--servers #{servers}" : nil} --rackup configuration.ru #{daemonize && servers ? '--daemonize' : nil} --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid start")
      end

      desc 'Stop the server(s)'
      task :stop do |task|
        system('for pid in ./process/thin/pid/thin.*.pid; do bundle exec thin --pid $pid stop; done')
      end

      desc 'Restart the server(s)'
      task :restart => ['pike:process:thin:stop',
                        'pike:process:thin:start']

    end

    namespace :cron do

      desc 'Install the schedule'
      task :install do |task|
        system("bundle exec whenever --load-file ./schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --update-crontab pike")
      end

      desc 'Uninstall the schedule'
      task :uninstall do |task|
        system("bundle exec whenever --load-file ./schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --clear-crontab pike")
      end

    end

  end

  namespace :data do

    desc 'Backup the database'
    task :backup, :stamp do |task, arguments|
      stamp = arguments.stamp || Time.now.strftime('%Y%m%d%H%M%S')
      system("rm -f pike.#{stamp}.tar.gz; rm -rf pike.#{stamp}; mongodump --db pike --out pike.#{stamp}; tar -czf pike.#{stamp}.tar.gz pike.#{stamp}; rm -rf pike.#{stamp}")
    end

    desc 'Restore a database backup'
    task :restore, [:stamp] => ['data:drop'] do |task, arguments|
      system("tar -xzf pike.#{arguments.stamp}.tar.gz; mongorestore --db pike --verbose --objcheck pike.#{arguments.stamp}/pike; rm -rf pike.#{arguments.stamp}")
    end

    desc 'Drop the database'
    task :drop do |task|
      Pike::Application.create_context! do
        Pike::Application.drop_database!
      end
    end

    namespace :actions do

      desc 'Print all actions'
      task :print_all do |task|
        Pike::Application.create_context! do
          table = Terminal::Table.new(:title => 'Actions',
                                      :headings => ['Type',
                                                    'Created',
                                                    'Failed',
                                                    'Class',
                                                    'Message']) do |table|
            count = Pike::System::Action.all.count
            Pike::System::Action.all.each_with_index do |action, index|
              table.add_row([action.class,
                             action.created_at,
                             action.exception_at,
                             action.exception_class,
                             action.exception_message])
              if action.exception_backtrace
                table.add_separator
                table.add_row([{:value => action.exception_backtrace.join("\n"), :colspan => 5}])
                table.add_separator unless index == count - 1
              end
            end
          end
          puts table
        end
      end

      desc 'Execute all actions'
      task :execute_all do |task|
        Pike::Application.create_context! do
          Pike::System::Action.execute_all!
        end
        Rake::Task['pike:data:actions:print_all'].invoke
      end

      desc 'Destroy all actions'
      task :destroy_all do |task|
        Pike::Application.create_context! do
          Pike::System::Action.all.each do |action|
            action.destroy
          end
        end
      end

      desc 'Destroy failed actions'
      task :destroy_failed do |task|
        Pike::Application.create_context! do
          Pike::System::Action.where_failed.each do |action|
            action.destroy
          end
        end
      end

    end

    namespace :identities do

      desc 'Print all identities'
      task :print_all do |task|
        Pike::Application.create_context! do
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
      end

      desc 'Expire all identities'
      task :expire_all do |task|
        Pike::Application.create_context! do
          Pike::System::Identity.all.each do |identity|
            identity.expires = Chronic.parse('yesterday')
            identity.save!
          end
        end
      end

    end

    namespace :users do

      desc 'Print all users'
      task :print_all do |task|
        Pike::Application.create_context! do
          table = Terminal::Table.new(:title => 'Users',
                                      :headings => ['Id',
                                                    'URL',
                                                    'Administrator?',
                                                    'Created',
                                                    'Updated']) do |table|
            Pike::User.all.each do |user|
              table.add_row([user.id,
                             user.url,
                             user.administrator?,
                             user.created_at,
                             user.updated_at])
            end
          end
          puts table
        end
      end

      desc 'Update user administrator'
      task :update_is_administrator, :url, :is_administrator do |task, arguments|
        Pike::Application.create_context! do
          is_administrator = arguments.is_administrator ? arguments.is_administrator.to_b : false
          user = Pike::User.get_user_by_url(arguments.url, false)
          user.set(:is_administrator, is_administrator) if user
        end
      end

    end

    namespace :projects do

      desc 'Print all projects'
      task :print_all do |task|
        Pike::Application.create_context! do
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

    end

    namespace :activities do

      desc 'Print all activities'
      task :print_all do |task|
        Pike::Application.create_context! do
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

    end

    namespace :tasks do

      desc 'Print all tasks'
      task :print_all do |task|
        Pike::Application.create_context! do
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

    end

    namespace :migrations do

      desc 'Print all migrations'
      task :print_all do |task|
        Pike::Application.create_context! do
          table = Terminal::Table.new(:title => 'Migrations',
                                      :headings => ['Name',
                                                    'Count',
                                                    'Created',
                                                    'Updated']) do |table|
            Pike::System::Migration.all.each do |migration|
              table.add_row([migration.name,
                             migration.count,
                             migration.created_at,
                             migration.updated_at])
            end
          end
          puts table
        end
      end

    end

    namespace :migrate do

      desc 'Run all migrations'
      task :all, [:force] => ['pike:data:migrate:add_user_url',
                              'pike:data:migrate:add_project_name',
                              'pike:data:migrate:add_activity_name',
                              'pike:data:migrate:update_task_project_and_activity_names',
                              'pike:data:migrate:update_user_demo_to_first',
                              'pike:data:migrate:add_friendship_user_target_url',
                              'pike:data:migrate:remove_identities_and_migrations_collections',
                              'pike:data:migrate:destroy_work_where_task_destroyed',
                              'pike:data:migrate:update_work_project_and_activity_names',
                              'pike:data:migrate:remove_nil_properties',
                              'pike:data:migrate:update_friendship_user_target_url',
                              'pike:data:migrate:add_user_is_administrator',
                              'pike:data:migrate:add_migration_count',
                              'pike:data:migrate:create_indexes',
                              'pike:data:migrate:create_property_indexes'] do |task, arguments|
      end

      desc 'Add the Pike::User#_url property'
      task :add_user_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect} user.set(:_url, #{user.url ? user.url.downcase.inspect : nil})"
              user.set(:_url, user.url ? user.url.downcase : nil)
            end
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::Project#_name property'
      task :add_project_name, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Project.all.each do |project| ...'
            Pike::Project.all.each do |project|
              puts "  project.name=#{project.name.inspect} project.set(:_name, #{project.name.downcase.inspect})"
              project.set(:_name, project.name.downcase)
            end
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::Activity#_name property'
      task :add_activity_name, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Activity.all.each do |activity| ...'
            Pike::Activity.all.each do |activity|
              puts "  activity.name=#{activity.name.inspect} activity.set(:_name, #{activity.name.downcase.inspect})"
              activity.set(:_name, activity.name.downcase)
            end
            puts '... end'
          end
        end
      end

      desc 'Update the Pike::Task#_project_name and Pike::Task#_activity_name properties'
      task :update_task_project_and_activity_names, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
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
      end

      desc 'Update the user demo@pike.virtualpatterns.com to first@pike.virtualpatterns.com'
      task :update_user_demo_to_first, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            user = Pike::User.get_user_by_url('demo@pike.virtualpatterns.com', false)
            if user
              puts "  user.url=#{user.url.inspect} user.url = #{'first@pike.virtualpatterns.com'.inspect} user.save!"
              user.url = 'first@pike.virtualpatterns.com'
              user.save!
            end
          end
        end
      end

      desc 'Add the Pike::Friendship#_user_target_url property'
      task :add_friendship_user_target_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Friendship.all.each do |friendship| ...'
            Pike::Friendship.all.each do |friendship|
              puts "  friendship.user_target.url=#{friendship.user_target ? friendship.user_target.url.inspect : '(nil)'} friendship.set(:_user_target_url, #{friendship.user_target ? friendship.user_target.url.downcase.inspect : '(nil)'})"
              friendship.set(:_user_target_url, friendship.user_target ? friendship.user_target.url.downcase : nil)
            end
            puts '... end'
          end
        end
      end

      desc 'Remove the identities and migrations collections'
      task :remove_identities_and_migrations_collections, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            database = Mongoid.configure.database
            puts 'database.drop_collection(\'identities\') ...'
            database.drop_collection('identities')
            puts '... done'
            puts 'database.drop_collection(\'migrations\') ...'
            database.drop_collection('migrations')
            puts '... done'
          end
        end
      end

      desc 'Destroy all work where the task has been destroyed'
      task :destroy_work_where_task_destroyed, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Work.all.each do |work| ...'
            Pike::Work.all.each do |work|
              puts "  work.date=#{work.date} work.duration=#{work.duration}"
              if work.task
                puts "    work.task.project.name=#{work.task.project.name.inspect} work.task.activity.name=#{work.task.activity.name.inspect}"
              else
                puts "    work.destroy"
                work.destroy
              end
            end
            puts '... end'
          end
        end
      end

      desc 'Update the Pike::Work#_project_name and Pike::Work#_activity_name properties'
      task :update_work_project_and_activity_names, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Work.all.each do |_work| ...'
            Pike::Work.all.each do |_work|
              puts "  _work.task.project.name=#{_work.task.project ? _work.task.project.name.inspect : '(nil)'} _work.set(:_project_name, #{_work.task.project ? _work.task.project.name.downcase.inspect : '(nil)'})"
              _work.set(:_project_name, _work.task.project ? _work.task.project.name.downcase : nil)
              puts "  _work.task.activity.name=#{_work.task.activity ? _work.task.activity.name.inspect : '(nil)'} _work.set(:_activity_name, #{_work.task.activity ? _work.task.activity.name.downcase.inspect : '(nil)'})"
              _work.set(:_activity_name, _work.task.activity ? _work.task.activity.name.downcase : nil)
            end
            puts '... end'
          end
        end
      end

      desc 'Remove any nil properties'
      task :remove_nil_properties, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect}"
              user.pull(:project_properties, nil) if user.send(:project_properties).include?(nil)
              user.pull(:activity_properties, nil) if user.send(:activity_properties).include?(nil)
              user.pull(:task_properties, nil) if user.send(:task_properties).include?(nil)
            end
            puts '... end'
          end
        end
      end

      desc 'Update the Pike::Friendship#_user_target_url property'
      task :update_friendship_user_target_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::Friendship.all.each do |friendship| ...'
            Pike::Friendship.all.each do |friendship|
              puts "  friendship.user_target.url=#{friendship.user_target ? friendship.user_target.url.inspect : '(nil)'} friendship.set(:_user_target_url, #{friendship.user_target ? friendship.user_target.url.downcase.inspect : '(nil)'})"
              friendship.set(:_user_target_url, friendship.user_target ? friendship.user_target.url.downcase : nil)
            end
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::User#is_administrator property'
      task :add_user_is_administrator, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect} user.set(:is_administrator, false)"
              user.set(:is_administrator, false)
            end
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::System::Migration#count property'
      task :add_migration_count, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Migration.all.each do |migration| ...'
            Pike::System::Migration.all.each do |migration|
              puts "  migration.name=#{migration.name.inspect} migration.set(:count, 1)"
              migration.set(:count, 1)
            end
            puts '... end'
          end
        end
      end

      desc 'Create indexes'
      task :create_indexes, :force do |task, arguments|

        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            $stdout.sync = true

            print 'Pike::User.create_indexes ... '
            Pike::User.create_indexes
            puts 'end'

            print 'Pike::System::Identity.create_indexes ... '
            Pike::System::Identity.create_indexes
            puts 'end'

            print 'Pike::Project.create_indexes ... '
            Pike::Project.create_indexes
            puts 'end'

            print 'Pike::Activity.create_indexes ... '
            Pike::Activity.create_indexes
            puts 'end'

            print 'Pike::Task.create_indexes ... '
            Pike::Task.create_indexes
            puts 'end'

            print 'Pike::Work.create_indexes ... '
            Pike::Work.create_indexes
            puts 'end'

            print 'Pike::Introduction.create_indexes ... '
            Pike::Introduction.create_indexes
            puts 'end'

            print 'Pike::Friendship.create_indexes ... '
            Pike::Friendship.create_indexes
            puts 'end'

            print 'Pike::System::Action.create_indexes ... '
            Pike::System::Action.create_indexes
            puts 'end'

            print 'Pike::System::Migration.create_indexes ... '
            Pike::System::Migration.create_indexes
            puts 'end'

          end
        end
      end

      desc 'Create property indexes'
      task :create_property_indexes, :force do |task, arguments|

        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            $stdout.sync = true

            print 'Pike::Property.create_indexes ... '
            Pike::Property.create_indexes
            puts 'end'

            print 'Pike::ProjectPropertyValue.create_indexes ... '
            Pike::ProjectPropertyValue.create_indexes
            puts 'end'

          end
        end
      end

      desc 'Create Pike::Property, Pike::ProjectPropertyValue, Pike::ActivityPropertyValue, and Pike::TaskPropertyValue from Pike::User#project_properties, Pike::User#activity_properties and Pike::User#task_properties'
      task :create_properties, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            # TODO ... index Pike::User.all
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect}"

              puts "    user.project_properties=#{user[:project_properties].inspect}"
              user[:project_properties] ||= []
              user[:project_properties].each do |property|
                puts "    property=#{property.inspect}"
                # TODO ... index user.properties.where_project and user.properties.where_name
                _property = user.properties.where_project.where_name(property).first || user.properties.create!(:type => Pike::Property::TYPE_PROJECT,
                                                                                                                :name => property)
                # TODO ... index user.projects.all
                user.projects.all.each do |project|
                  puts "      project.name=#{project.name.inspect}"
                  # TODO ... index project.values.where_property
                  value = project.values.where_property(_property).first || project.values.create!(:property  => _property,
                                                                                                   :value     => project[property])
                  project.unset(property)
                end
                user.unset(:project_properties)
              end

              puts "    user.activity_properties=#{user[:activity_properties].inspect}"
              user[:activity_properties] ||= []
              user[:activity_properties].each do |property|
                puts "    property=#{property.inspect}"
                # TODO ... index user.properties.where_type_and_name
                _property = user.properties.where_activity.where_name(property).first || user.properties.create!(:type => Pike::Property::TYPE_ACTIVITY,
                                                                                                                 :name => property)
                # TODO ... index user.activities.all
                user.activities.all.each do |activity|
                  puts "      activity.name=#{activity.name.inspect}"
                  # TODO ... index activity.values.where_property
                  value = activity.values.where_property(_property).first || activity.values.create!(:property  => _property,
                                                                                                     :value     => activity[property])
                  activity.unset(property)
                end
                user.unset(:activity_properties)
              end

              puts "    user.task_properties=#{user[:task_properties].inspect}"
              user[:task_properties] ||= []
              user[:task_properties].each do |property|
                puts "    property=#{property.inspect}"
                # TODO ... index user.properties.where_type_and_name
                _property = user.properties.where_task.where_name(property).first || user.properties.create!(:type => Pike::Property::TYPE_TASK,
                                                                                                             :name => property)
                # TODO ... index user.tasks.all
                user.tasks.all.each do |task|
                  puts "      task.project.name=#{task.project.name.inspect} task.activity.name=#{task.activity.name.inspect}"
                  # TODO ... index task.values.where_property
                  value = task.values.where_property(_property).first || task.values.create!(:property  => _property,
                                                                                             :value     => task[property])
                  task.unset(property)
                end
                user.unset(:task_properties)
              end

            end
            puts '... end'
          end
        end
      end

      # Next migration ...
      #   ...

    end

    namespace :indexes do

      desc 'Verify queries are supported by indexes'
      task :assert do |task|
        Pike::Application.create_context! do
          $stdout.sync = true

          print 'Pike::User.assert_indexes ... '
          Pike::User.assert_indexes
          puts 'end'

          print 'Pike::System::Identity.assert_indexes ... '
          Pike::System::Identity.assert_indexes
          puts 'end'

          print 'Pike::Project.assert_indexes ... '
          Pike::Project.assert_indexes
          puts 'end'

          print 'Pike::Activity.assert_indexes ... '
          Pike::Activity.assert_indexes
          puts 'end'

          print 'Pike::Task.assert_indexes ... '
          Pike::Task.assert_indexes
          puts 'end'

          print 'Pike::Property.assert_indexes ... '
          Pike::Property.assert_indexes
          puts 'end'

          print 'Pike::ProjectPropertyValue.assert_indexes ... '
          Pike::ProjectPropertyValue.assert_indexes
          puts 'end'

          print 'Pike::Work.assert_indexes ... '
          Pike::Work.assert_indexes
          puts 'end'

          print 'Pike::Introduction.assert_indexes ... '
          Pike::Introduction.assert_indexes
          puts 'end'

          print 'Pike::Friendship.assert_indexes ... '
          Pike::Friendship.assert_indexes
          puts 'end'

          print 'Pike::System::Action.assert_indexes ... '
          Pike::System::Action.assert_indexes
          puts 'end'

          print 'Pike::System::Migration.assert_indexes ... '
          Pike::System::Migration.assert_indexes
          puts 'end'

        end
      end

    end

  end

  namespace :cache do

    desc 'List all cached files'
    task :list do
      system('find . | grep \'\\.cache\'')
    end

    desc 'Remove all cached files'
    task :destroy do
      puts 'Removing cached files ...'
      system('find . -name \'.cache\' | xargs rm -rv')
    end

  end

end
