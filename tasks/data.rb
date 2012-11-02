require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'terminal-table'

require 'tasks/data/migrations'

namespace :pike do

  namespace :data do

    desc 'Backup the database'
    task :backup, :stamp do |task, arguments|
      stamp = arguments.stamp || Time.now.strftime('%Y%m%d%H%M%S')
      system("rm -f pike.#{stamp}.tar.gz; rm -rf pike.#{stamp}; mongodump --db pike --out pike.#{stamp}; tar -czf pike.#{stamp}.tar.gz pike.#{stamp}; rm -rf pike.#{stamp}")
    end

    desc 'Restore a database backup'
    task :restore, [:stamp] => ['data:destroy'] do |task, arguments|
      system("tar -xzf pike.#{arguments.stamp}.tar.gz; mongorestore --db pike --verbose --objcheck pike.#{arguments.stamp}/pike; rm -rf pike.#{arguments.stamp}")
    end

    desc 'Drop the database'
    task :destroy do |task|
      Pike::Application.create_context! do
        Pike::Application.destroy_database!
      end
    end

    desc 'Reset the database'
    task :reset => ['pike:data:destroy',
                    'pike:data:indexes:create_all']

    namespace :log do

      desc 'Rotate the log'
      task :rotate do |task|
        system("mongo --verbose admin #{File.join(File.dirname(__FILE__), %w[rotateLog.js])}")
      end

    end

    namespace :profile do

      desc 'Turn on database profiling'
      task :enable do |task|
        Pike::Application.create_context! do
          system("mongo --verbose #{Pike::Application.configuration.mongodb.database} #{File.join(File.dirname(__FILE__), %w[enableProfiling.js])}")
        end
      end

      desc 'Reset database profiling'
      task :reset => ['pike:data:destroy',
                      'pike:data:indexes:create_all',
                      'pike:data:profile:enable']

      desc 'Turn off database profiling'
      task :disable do |task|
        Pike::Application.create_context! do
          system("mongo --verbose #{Pike::Application.configuration.mongodb.database} #{File.join(File.dirname(__FILE__), %w[disableProfiling.js])}")
        end
      end

      desc 'Report on queries not indexed or where scanned objects are greater than objects returned'
      task :report, :_class do |task, arguments|
        Pike::Application.create_context! do
          _class = arguments._class ? Kernel.eval(arguments._class) : nil
          query = {'op'     => 'query'}
          query.merge!('ns' => "pike.#{_class.collection.name}") if _class
          order = BSON::OrderedHash.new
          order['ts'] = -1
          Mongoid.configure.master.collection('system.profile').find(query).sort(order).each do |document|
            document['ns'] =~ /pike\.(.*)/
            collection = $1
            _query = document['query'].merge('$explain' => true)
            explanation = Mongoid.configure.master.collection(collection).find(_query).explain
            if  explanation['cursor'] !~ /BtreeCursor/ ||
                explanation['nscannedObjects']  > explanation['n']
              puts '-' * 80
              puts "Collection ... #{collection}"
              puts "Date/Time .... #{document['ts']}"
              puts "Cursor  ...... #{explanation['cursor']}"
              puts "Scanned ...... #{explanation['nscannedObjects']}"
              puts "Returned ..... #{explanation['n']}"
              # puts '-' * 80
              # ap document
              puts '-' * 80
              ap document['query']
              puts '-' * 80
              ap explanation
              puts '-' * 80
            end
          end
        end
      end

  end

    namespace :actions do

      desc 'Print all actions'
      task :print_all do |task|
        Pike::Application.create_context! do
          table = Terminal::Table.new(:title => 'Actions',
                                      :headings => ['Type',
                                                    'Index',
                                                    'Created',
                                                    'Failed',
                                                    'Class',
                                                    'Message']) do |table|
            count = Pike::System::Action.all.count
            Pike::System::Action.all.each_with_index do |action, index|
              table.add_row([action.class,
                             action.index,
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
          Pike::System::Action.destroy_all
        end
      end

      desc 'Destroy failed actions'
      task :destroy_failed do |task|
        Pike::Application.create_context! do
          Pike::System::Action.destroy_all(:state => Pike::System::Action::STATE_EXECUTED)
        end
      end

    end

    namespace :identities do

      desc 'Print all identities'
      task :print_all do |task|
        Pike::Application.create_context! do
          table = Terminal::Table.new(:title => 'Identities',
                                      :headings => ['User',
                                                    'Source',
                                                    'Created',
                                                    'Expires']) do |table|
            Pike::System::Identity.all.each do |identity|
              table.add_row([identity.user.url,
                             Pike::System::Identity::SOURCE_NAMES[identity.source],
                             identity.created_at,
                             identity.expires_at])
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
                                                    'Name',
                                                    'Administrator?',
                                                    'Created',
                                                    'Updated']) do |table|
            Pike::User.all.each do |user|
              table.add_row([user.id,
                             user.url,
                             user.name,
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
                             project.copy? ? project.copy_of.id : nil,
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
                             activity.copy? ? activity.copy_of.id : nil,
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

    namespace :messages do

      desc 'Create a message'
      task :create, :subject, :body do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Message.create!(:subject  => arguments.subject,
                                        :body     => arguments.body)
        end
      end

    end

    namespace :indexes do

      desc 'Create indexes for a class'
      task :create, [:_class] => ['pike:data:indexes:destroy'] do |task, arguments|
        Pike::Application.create_context! do
          $stdout.sync = true
          _class = Kernel.eval(arguments._class)
          print "#{_class}.create_indexes ... "
          _class.create_indexes
          puts 'end'
        end
      end

      desc 'Create all indexes'
      task :create_all => ['pike:data:indexes:destroy_all'] do |task|
        Pike::Application.create_context! do
          $stdout.sync = true
          [ Pike::User,
            Pike::System::Identity,
            Pike::Property,
            Pike::Project,
            Pike::ProjectPropertyValue,
            Pike::Activity,
            Pike::ActivityPropertyValue,
            Pike::Task,
            Pike::TaskPropertyValue,
            Pike::Work,
            Pike::Introduction,
            Pike::Friendship,
            Pike::System::Message,
            Pike::System::MessageState,
            Pike::System::Action,
            Pike::System::Migration ].each do |_class|
            print "#{_class}.create_indexes ... "
            _class.create_indexes
            puts 'end'
          end
        end
      end

      desc 'Destroy indexes for a class'
      task :destroy, :_class do |task, arguments|
        Pike::Application.create_context! do
          $stdout.sync = true
          _class = Kernel.eval(arguments._class)
          print "#{_class}.collection.drop_indexes ... "
          _class.collection.drop_indexes
          puts 'end'
        end
      end

      desc 'Destroy all indexes'
      task :destroy_all do |task|
        Pike::Application.create_context! do
          $stdout.sync = true
          [ Pike::User,
            Pike::System::Identity,
            Pike::Property,
            Pike::Project,
            Pike::ProjectPropertyValue,
            Pike::Activity,
            Pike::ActivityPropertyValue,
            Pike::Task,
            Pike::TaskPropertyValue,
            Pike::Work,
            Pike::Introduction,
            Pike::Friendship,
            Pike::System::Message,
            Pike::System::MessageState,
            Pike::System::Action,
            Pike::System::Migration ].each do |_class|
            print "#{_class}.collection.drop_indexes ... "
            _class.collection.drop_indexes
            puts 'end'
          end
        end
      end

      desc 'Verify queries are supported by indexes for a class'
      task :assert, :_class do |task, arguments|
        Pike::Application.create_context! do
          $stdout.sync = true
          _class = Kernel.eval(arguments._class)
          print "#{_class}.assert_indexes ... "
          _class.assert_indexes
          puts 'end'
        end
      end

      desc 'Verify queries are supported by indexes'
      task :assert_all do |task|
        Pike::Application.create_context! do
          $stdout.sync = true
          [ Pike::User,
            Pike::System::Identity,
            Pike::Property,
            Pike::Project,
            Pike::ProjectPropertyValue,
            Pike::Activity,
            Pike::ActivityPropertyValue,
            Pike::Task,
            Pike::TaskPropertyValue,
            Pike::Work,
            Pike::Introduction,
            Pike::Friendship,
            Pike::System::Message,
            Pike::System::MessageState,
            Pike::System::Action,
            Pike::System::Migration ].each do |_class|
            print "#{_class}.assert_indexes ... "
            _class.assert_indexes
            puts 'end'
          end
        end
      end

    end

  end

end
