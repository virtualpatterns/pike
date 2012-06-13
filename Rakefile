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
    system("git checkout development; git pull origin development; git tag -a -m 'Tagging #{Pike::VERSION}' '#{Pike::VERSION}'; git push origin development")
    version_file = File.join(Pike::ROOT, %w[lib pike version.rb])
    Pike::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
    system("sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'")
    system('git commit --all --message=\'Incrementing version\'')
  end

  namespace :merge do

    desc 'Merge development and staging, push staging'
    task :staging do |task|
      system('git checkout staging; git pull origin staging; git merge origin/development; git push origin staging; git checkout development')
    end

    desc 'Merge staging and production, push production'
    task :production do |task|
      system('git checkout production; git pull origin production; git merge origin/staging; git push origin production; git checkout development')
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
        system("#{servers == 1 ? 'rm -f ./process/thin/pid/thin.pid' : 'rm -f ./process/thin/pid/thin.*.pid'}; #{daemonize ? nil : 'clear; '} bundle exec thin --port 8008 #{servers > 1 ? "--servers #{servers}" : nil} --rackup configuration.ru #{daemonize && servers ? '--daemonize' : nil} --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid start")
      end

      desc 'Stop the server(s)'
      task :stop do |task|
        system('for pid in ./process/thin/pid/thin.*.pid; do bundle exec thin --pid $pid stop; done')
      end

      desc 'Restart the server(s)'
      task :restart => ['pike:process:thin:stop',
                        'pike:process:thin:start']

    end

  end

  namespace :data do

    desc 'Dump the database to ./dump.tgz'
    task :dump do |task|
      system('rm -f dump.tgz; rm -rf dump; mongodump --db pike --out dump; tar -czf dump.tgz dump; rm -rf dump')
    end

    desc 'Restore a dumped database from ./dump.tgz'
    task :restore => ['data:drop'] do |task|
      system('rm -rf dump; tar -xzf dump.tgz; mongorestore --db pike --verbose --objcheck dump/pike; rm -rf dump')
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

    namespace :migrate do

      desc 'Run all migrations'
      task :all => ['pike:data:migrate:add_user_url',
                    'pike:data:migrate:add_project_name',
                    'pike:data:migrate:add_activity_name',
                    'pike:data:migrate:update_task_project_and_activity_names',
                    'pike:data:migrate:update_user_demo_to_first',
                    'pike:data:migrate:add_friendship_user_target_url',
                    'pike:data:migrate:remove_identities_and_migrations_collections',
                    'pike:data:migrate:destroy_work_where_task_destroyed',
                    'pike:data:migrate:update_work_project_and_activity_names',
                    'pike:data:migrate:remove_nil_properties',
                    'pike:data:migrate:update_friendship_user_target_url'] do |task|
      end

      desc 'Add the Pike::User#_url property'
      task :add_user_url do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :add_project_name do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :add_activity_name do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :update_task_project_and_activity_names do |task|
        Pike::Application.create_context! do
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
      end

      desc 'Update the user demo@pike.virtualpatterns.com to first@pike.virtualpatterns.com'
      task :update_user_demo_to_first do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :add_friendship_user_target_url do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :remove_identities_and_migrations_collections do |task|
        Pike::Application.create_context! do
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
      end

      desc 'Destroy all work where the task has been destroyed'
      task :destroy_work_where_task_destroyed do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :update_work_project_and_activity_names do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :remove_nil_properties do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
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
      task :update_friendship_user_target_url do |task|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task) do
            puts 'Pike::Friendship.all.each do |friendship| ...'
            Pike::Friendship.all.each do |friendship|
              puts "  friendship.user_target.url=#{friendship.user_target ? friendship.user_target.url.inspect : '(nil)'} friendship.set(:_user_target_url, #{friendship.user_target ? friendship.user_target.url.downcase.inspect : '(nil)'})"
              friendship.set(:_user_target_url, friendship.user_target ? friendship.user_target.url.downcase : nil)
            end
            puts '... end'
          end
        end
      end

      # Next migration ...
      #   ...

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
