namespace :pike do

  namespace :data do

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
                              'pike:data:migrate:add_action_index',
                              'pike:data:migrate:create_properties',
                              'pike:data:migrate:add_user_read_messages',
                              'pike:data:migrate:add_message_0_5_98',
                              'pike:data:migrate:add_message_0_5_101',
                              'pike:data:migrate:add_message_0_5_106',
                              'pike:data:migrate:add_message_0_5_108',
                              'pike:data:migrate:add_identity_source',
                              'pike:data:migrate:add_message_0_5_109'] do |task, arguments|
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

      desc 'Delete the identities and migrations collections'
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

      desc 'Delete any nil properties'
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

      desc 'Add the Pike::System::Action#index property'
      task :add_action_index, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Action.all.each do |action| ...'
            Pike::System::Action.all.each do |action|
              index = Pike::System::Sequence.next('Pike::System::Action#index')
              puts "  action.class=#{action.class} action.set(:index, #{index.inspect})"
              migration.set(:index, index)
            end
            puts '... end'
          end
        end
      end

      desc 'Create Pike::Property, Pike::ProjectPropertyValue, Pike::ActivityPropertyValue, and Pike::TaskPropertyValue from Pike::User#project_properties, Pike::User#activity_properties and Pike::User#task_properties'
      task :create_properties, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect}"

              puts "    user.project_properties=#{user[:project_properties].inspect}"
              user[:project_properties] ||= []
              user[:project_properties].each do |property|
                puts "    property=#{property.inspect}"
                user.projects.all.each do |project|
                  puts "      project.name=#{project.name.inspect}"
                  project.create_value!(property, project[property]) unless project.copy?
                  project.unset(property)
                end
              end
              user.unset(:project_properties)

              puts "    user.activity_properties=#{user[:activity_properties].inspect}"
              user[:activity_properties] ||= []
              user[:activity_properties].each do |property|
                puts "    property=#{property.inspect}"
                user.activities.all.each do |activity|
                  puts "      activity.name=#{activity.name.inspect}"
                  activity.create_value!(property, activity[property]) unless activity.copy?
                  activity.unset(property)
                end
              end
              user.unset(:activity_properties)

              puts "    user.task_properties=#{user[:task_properties].inspect}"
              user[:task_properties] ||= []
              user[:task_properties].each do |property|
                puts "    property=#{property.inspect}"
                user.tasks.all.each do |task|
                  puts "      task.project.name=#{task.project.name.inspect} task.activity.name=#{task.activity.name.inspect}"
                  task.create_value!(property, task[property])
                  task.unset(property)
                end
              end
              user.unset(:task_properties)

            end
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::User#read_messages property'
      task :add_user_read_messages, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::User.all.each do |user| ...'
            Pike::User.all.each do |user|
              puts "  user.url=#{user.url.inspect} user.set(:read_messages, [])"
              user.set(:read_messages, [])
            end
            puts '... end'
          end
        end
      end

      desc 'Add the message for Version 0.5.98'
      task :add_message_0_5_98, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Message.create ...'
            subject = 'Version 0.5.98'
            body = <<-MESSAGE
Changes in this version ...

* Added messaging feature for new version changes and additions, proposed downtime, etc.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
            puts '... end'
          end
        end
      end

      desc 'Add the message for Version 0.5.101'
      task :add_message_0_5_101, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Message.create ...'
            subject = 'Version 0.5.101'
            body = <<-MESSAGE
Changes in this version ...

* Updated RubyApp gem to 0.6.28 allowing for the rotation of the application log through the HUP signal

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
            puts '... end'
          end
        end
      end

      desc 'Add the message for Version 0.5.106'
      task :add_message_0_5_106, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Message.create ...'
            subject = 'Version 0.5.106'
            body = <<-MESSAGE
Changes in this version ...

* Updated the message count 'N pending' on the work list to 'N unread'

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
            puts '... end'
          end
        end
      end

      desc 'Add the message for Version 0.5.108'
      task :add_message_0_5_108, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Message.create ...'
            subject = 'Version 0.5.108'
            body = <<-MESSAGE
Changes in this version ...

* Added a GitHub logon and re-ordered the logon buttons on the first page

**NOTE:** Properties in the weekly summary export are now sorted alphabetically.  There was previously no defined sort order and, as a result, columns may have shifted between older and newer reports.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
            puts '... end'
          end
        end
      end

      desc 'Add the Pike::System::Identity#source property'
      task :add_identity_source, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Identity.all.each do |identity| ...'
            Pike::System::Identity.all.each do |identity|
              puts "  identity.user.url=#{identity.user.url.inspect} identity.set(:source, Pike::System::Identity::SOURCE_UNKNOWN)"
              identity.set(:source, Pike::System::Identity::SOURCE_UNKNOWN)
            end
            puts '... end'
          end
        end
      end

      desc 'Add the message for Version 0.5.109'
      task :add_message_0_5_109, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            puts 'Pike::System::Message.create ...'
            subject = 'Version 0.5.109'
            body = <<-MESSAGE
Changes in this version ...

* Decreased the size of the stopwatch image to accomodate the logon buttons on the home page for mobile devices
* Added the ability to import GitHub repositories for users who logon via GitHub and have created no projects (e.g. first-time GitHub users)

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
            puts '... end'
          end
        end
      end

      # Next migration ...
      #   ...

    end

  end

end