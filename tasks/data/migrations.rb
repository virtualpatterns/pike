namespace :pike do

  namespace :data do

    desc 'Run all migrations'
    task :migrate_all, [:force] => ['pike:data:migrate:add_user_url',
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
                                    'pike:data:migrate:add_message_0_5_109',
                                    'pike:data:migrate:add_message_0_5_112',
                                    'pike:data:migrate:add_user_name',
                                    'pike:data:migrate:add_message_0_5_113',
                                    'pike:data:migrate:add_message_0_5_114',
                                    'pike:data:migrate:rename_work_started_updated',
                                    'pike:data:migrate:destroy_identities',
                                    'pike:data:migrate:add_work_is_started',
                                    'pike:data:migrate:add_action_failed',
                                    'pike:data:migrate:add_message_0_5_116',
                                    'pike:data:migrate:remove_action_failed',
                                    'pike:data:migrate:add_action_state',
                                    'pike:data:migrate:transform_user_read_messages',
                                    'pike:data:migrate:add_message_0_5_119',
                                    'pike:data:migrate:add_message_0_5_120',
                                    'pike:data:migrate:add_message_0_5_122',
                                    'pike:data:migrate:add_message_0_5_123',
                                    'pike:data:migrate:add_message_0_5_124',
                                    'pike:data:migrate:add_message_0_5_125',
                                    'pike:data:migrate:add_message_0_5_128',
                                    'pike:data:migrate:add_message_0_5_130',
                                    'pike:data:migrate:add_message_0_5_134',
                                    'pike:data:migrate:add_message_0_5_135',
                                    'pike:data:migrate:destroy_indexes',
                                    'pike:data:migrate:re_create_indexes',
                                    'pike:data:migrate:add_message_0_5_141',
                                    'pike:data:migrate:add_message_0_5_143',
                                    'pike:data:migrate:add_message_0_5_144',
                                    'pike:data:migrate:re_destroy_work_where_task_destroyed',
                                    'pike:data:migrate:add_message_0_5_146',
                                    'pike:data:migrate:create_user_search_index',
                                    'pike:data:migrate:add_message_0_5_169',
                                    'pike:data:migrate:rename_user_url_uri',
                                    'pike:data:migrate:rename_message_state_system_message_state',
                                    'pike:data:migrate:add_message_0_6_0',
                                    'pike:data:migrate:remove_pike_system_sequences_collection'] do |task, arguments|
    end

    namespace :migrate do

      desc 'Add the Pike::User#_url property'
      task :add_user_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.all.each do |user|
              user.set(:_url, user[:url] ? user[:url].downcase : nil)
            end
          end
        end
      end

      desc 'Add the Pike::Project#_name property'
      task :add_project_name, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Project.all.each do |project|
              project.set(:_name, project[:name] ? project[:name].downcase : nil)
            end
          end
        end
      end

      desc 'Add the Pike::Activity#_name property'
      task :add_activity_name, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Activity.all.each do |activity|
              activity.set(:_name, activity[:name] ? activity[:name].downcase : nil)
            end
          end
        end
      end

      desc 'Update the Pike::Task#_project_name and Pike::Task#_activity_name properties'
      task :update_task_project_and_activity_names, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Task.all.each do |_task|
              _task.set(:_project_name, _task[:project] && _task[:project][:name] ? _task[:project][:name].downcase : nil)
              _task.set(:_activity_name, _task[:activity] && _task[:activity][:name] ? _task[:activity][:name].downcase : nil)
            end
          end
        end
      end

      desc 'Update the user demo@pike.virtualpatterns.com to first@pike.virtualpatterns.com'
      task :update_user_demo_to_first, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.find(:url => 'demo@pike.virtualpatterns.com').update('$set' => {:url => 'first@pike.virtualpatterns.com'}) rescue puts $!.message
          end
        end
      end

      desc 'Add the Pike::Friendship#_user_target_url property'
      task :add_friendship_user_target_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Friendship.all.each do |friendship|
              friendship.set(:_user_target_url, friendship[:user_target] && friendship[:user_target][:url] ? friendship[:user_target][:url].downcase : nil)
            end
          end
        end
      end

      desc 'Delete the identities and migrations collections'
      task :remove_identities_and_migrations_collections, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Mongoid.default_session['identities'].drop
            Mongoid.default_session['migrations'].drop
          end
        end
      end

      desc 'Destroy all work where the task has been destroyed'
      task :destroy_work_where_task_destroyed, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Work.all.each do |work|
              work.destroy unless work[:task]
            end
          end
        end
      end

      desc 'Update the Pike::Work#_project_name and Pike::Work#_activity_name properties'
      task :update_work_project_and_activity_names, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Work.all.each do |_work|
              _work.set(:_project_name, _work[:task] && _work[:task][:project] && _work[:task][:project][:name] ? _work[:task][:project][:name].downcase : nil)
              _work.set(:_activity_name, _work[:task] && _work[:task][:activity] && _work[:task][:activity][:name] ? _work[:task][:activity][:name].downcase : nil)
            end
          end
        end
      end

      desc 'Delete any nil properties'
      task :remove_nil_properties, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.all.each do |user|
              user.pull(:project_properties, nil) if ( user[:project_properties] || [] ).include?(nil)
              user.pull(:activity_properties, nil) if ( user[:activity_properties] || [] ).include?(nil)
              user.pull(:task_properties, nil) if ( user[:task_properties] || [] ).include?(nil)
            end
          end
        end
      end

      desc 'Update the Pike::Friendship#_user_target_url property'
      task :update_friendship_user_target_url, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Friendship.all.each do |friendship|
              friendship.set(:_user_target_url, friendship[:user_target] && friendship[:user_target][:url] ? friendship[:user_target][:url].downcase : nil)
            end
          end
        end
      end

      desc 'Add the Pike::User#is_administrator property'
      task :add_user_is_administrator, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.update_all('$set' => {:is_administrator => false})
          end
        end
      end

      desc 'Add the Pike::System::Migration#count property'
      task :add_migration_count, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Migration.update_all('$set' => {:count => 1})
          end
        end
      end

      desc 'Add the Pike::System::Action#index property'
      task :add_action_index, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Action.all.each do |action|
              index = Pike::System::Sequence.next('Pike::System::Action#index')
              action.set(:index, index)
            end
          end
        end
      end

      desc 'Create Pike::Property, Pike::ProjectPropertyValue, Pike::ActivityPropertyValue, and Pike::TaskPropertyValue from Pike::User#project_properties, Pike::User#activity_properties and Pike::User#task_properties'
      task :create_properties, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.all.each do |user|

              user[:project_properties] ||= []
              user[:project_properties].each do |property|
                user.projects.all.each do |project|
                  project.create_value!(property, project[property]) unless project.copy?
                  project.unset(property)
                end
              end
              user.unset(:project_properties)

              user[:activity_properties] ||= []
              user[:activity_properties].each do |property|
                user.activities.all.each do |activity|
                  activity.create_value!(property, activity[property]) unless activity.copy?
                  activity.unset(property)
                end
              end
              user.unset(:activity_properties)

              user[:task_properties] ||= []
              user[:task_properties].each do |property|
                user.tasks.all.each do |task|
                  task.create_value!(property, task[property])
                  task.unset(property)
                end
              end
              user.unset(:task_properties)

            end
          end
        end
      end

      desc 'Add the Pike::User#read_messages property'
      task :add_user_read_messages, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.update_all('$set' => {:read_messages => []})
          end
        end
      end

      desc 'Add the message for Version 0.5.98'
      task :add_message_0_5_98, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.98'
            body = <<-MESSAGE
Changes in this version ...

* Added messaging feature for new version changes and additions, proposed downtime, etc.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.101'
      task :add_message_0_5_101, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.101'
            body = <<-MESSAGE
Changes in this version ...

* Updated RubyApp gem to 0.6.28 allowing for the rotation of the application log through the HUP signal

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.106'
      task :add_message_0_5_106, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.106'
            body = <<-MESSAGE
Changes in this version ...

* Updated the message count 'N pending' on the work list to 'N unread'

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.108'
      task :add_message_0_5_108, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.108'
            body = <<-MESSAGE
Changes in this version ...

* Added a GitHub logon and re-ordered the logon buttons on the first page

**NOTE:** Properties in the weekly summary export are now sorted alphabetically.  There was previously no defined sort order and, as a result, columns may have shifted between older and newer reports.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the Pike::System::Identity#source property'
      task :add_identity_source, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Identity.update_all('$set' => {:source => Pike::System::Identity::SOURCE_UNKNOWN})
          end
        end
      end

      desc 'Add the message for Version 0.5.109'
      task :add_message_0_5_109, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.109'
            body = <<-MESSAGE
Changes in this version ...

* Decreased the size of the stopwatch image to accomodate the logon buttons on the home page for mobile devices
* Added the ability to import GitHub repositories for users who logon via GitHub and have created no projects (e.g. first-time GitHub users)

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.112'
      task :add_message_0_5_112, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.112'
            body = <<-MESSAGE
Changes in this version ...

* Modified GitHub, Google, and Facebook logons to retrieve user's name
* Modified the first, second, and random guest logons to set the user's name to First User, Second User, and Random User respectively
* Added a welcome message that includes the user's name and email to the work list page that disappears after a delay
* Added a user search by name to the introduction page avoiding the need to remember and enter a user's email ... the current user does not appear in a user search

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the Pike::User#name property where it\'s nil'
      task :add_user_name, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.where_name(nil).each do |user|
              user[:_url] =~ /([^\@]+)@.*/
              abbreviated_url = "#{$1}@..."
              user.set(:name, abbreviated_url)
            end
          end
        end
      end

      desc 'Add the message for Version 0.5.113'
      task :add_message_0_5_113, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.113'
            body = <<-MESSAGE
Changes in this version ...

* Modified the user and introductions lists and introduction page to include names and abbreviated emails
* Modified the friends list to include names and emails
* Modified the projects, activities, and properties lists to show the sharing user's name instead of email
* For users with no name, updating their name to their abbreviated email ... their first logon will update the name to that provided by the logon provider

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.114'
      task :add_message_0_5_114, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.114'
            body = <<-MESSAGE
Changes in this version ...

* Removed the Versions section on the About page

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Rename Pike::Work#started and Pike::Work#updated to Pike::Work#started_at and Pike::Work#updated_at respectively'
      task :rename_work_started_updated, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Work.update_all('$rename' => {'started' => 'started_at'})
            Pike::Work.update_all('$rename' => {'updated' => 'updated_at'})
          end
        end
      end

      desc 'Destroy all Pike::System::Identity'
      task :destroy_identities, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Identity.destroy_all
          end
        end
      end

      desc 'Add Pike::Work#is_started'
      task :add_work_is_started, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::Work.all.each do |work|
              work.set(:is_started, work[:started_at] ? true : false)
             end
          end
        end
      end

      desc 'Add Pike::System::Action#failed'
      task :add_action_failed, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Action.all.each do |action|
              action.set(:failed, action[:exception_at] ? true : false)
             end
          end
        end
      end

      desc 'Add the message for Version 0.5.116'
      task :add_message_0_5_116, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.116'
            body = <<-MESSAGE
Changes in this version ...

* Performance improvements

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      # Remove Pike::System::Action#failed
      desc 'Remove Pike::System::Action#failed'
      task :remove_action_failed, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Action.update_all('$unset' => {:failed => 1})
          end
        end
      end

      desc 'Add Pike::System::Action#state'
      task :add_action_state, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::System::Action.all.each do |action|
              action.set(:state, action[:exception_at] ? Pike::System::Action::STATE_EXECUTED : Pike::System::Action::STATE_PENDING)
             end
          end
        end
      end

      desc 'Transform Pike::User#read_messages into Pike::System::MessageState'
      task :transform_user_read_messages, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do

            Pike::System::MessageState.collection.indexes.drop rescue puts $!.message
            Pike::System::MessageState.collection.indexes.create({:user_id      => 1,
                                                                  :message_id   => 1,
                                                                  :state        => 1,
                                                                  :created_at   => 1}, :name => 'user')

            
            Pike::System::Message.unscoped.all.order_by([[:created_at, :asc]]).each do |message|
              Pike::User.all.each do |user|
                message_state = user.message_states.where_message(message).first || user.message_states.create!(:message => message)
                message_state.state = Pike::System::MessageState::STATE_NEW
                message_state.save!
              end
             end

            Pike::User.all.each do |user|
              user[:read_messages].each do |id|
                message = Pike::System::Message.find(id)
                message_state = user.message_states.where_message(message).first
                message_state.state = Pike::System::MessageState::STATE_READ
                message_state.save!
              end
              user.unset(:read_messages)
            end

          end
        end
      end

      desc 'Add the message for Version 0.5.119'
      task :add_message_0_5_119, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.119'
            body = <<-MESSAGE
Changes in this version ...

* Performance improvements

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.120'
      task :add_message_0_5_120, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.120'
            body = <<-MESSAGE
Changes in this version ...

* Fixed sharing and weekly summary exports.  A previous update broke the process that ran these actions.  This update fixes that.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.122'
      task :add_message_0_5_122, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.122'
            body = <<-MESSAGE
Changes in this version ...

* Modified the icon for the GitHub refresh/import item.  When refreshing GitHub access the item shows a refresh icon.  
When downloading repositories from GitHub the item shows a downward arrow.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.123'
      task :add_message_0_5_123, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.123'
            body = <<-MESSAGE
Changes in this version ...

* Minor user-interface updates.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.124'
      task :add_message_0_5_124, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.124'
            body = <<-MESSAGE
Changes in this version ...

* Introductions sent by you but not yet accepted or ignored are visible on the Friends page and can be deleted.  In order to keep the list manageable, there are separate sections for introductions sent BY you and introductions sent TO you.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.125'
      task :add_message_0_5_125, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.125'
            body = <<-MESSAGE
Changes in this version ...

* Resolved an issue that caused the current page not to render when refreshed.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.128'
      task :add_message_0_5_128, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.128'
            body = <<-MESSAGE
Changes in this version ...

* Resolved an issue that required a 'tab' off an input element before clicking a button.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
         end
        end
      end

      desc 'Add the message for Version 0.5.130'
      task :add_message_0_5_130, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.130'
            body = <<-MESSAGE
Changes in this version ...

* Enabled auto-focus on the search field of the user selection page.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.134'
      task :add_message_0_5_134, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Verson 0.5.134'
            body = <<-MESSAGE
Changes in this version ...

* Display the selected user when user selection is displayed and there was previously a selected user.  The search field and results are populated with the name of the selected user.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.135'
      task :add_message_0_5_135, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.135'
            body = <<-MESSAGE
Changes in this version ...

* The work list is now refreshed after an update cycle if a message is created since logon or the last refresh.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Destroy all indexes'
      task :destroy_indexes, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do

            Pike::User.collection.indexes.drop rescue puts $!.message
            Pike::System::Identity.collection.indexes.drop rescue puts $!.message

            Pike::Property.collection.indexes.drop rescue puts $!.message
            Pike::PropertyValue.collection.indexes.drop rescue puts $!.message

            Pike::Project.collection.indexes.drop rescue puts $!.message
            Pike::ProjectPropertyValue.collection.indexes.drop rescue puts $!.message

            Pike::Activity.collection.indexes.drop rescue puts $!.message
            Pike::ActivityPropertyValue.collection.indexes.drop rescue puts $!.message

            Pike::Task.collection.indexes.drop rescue puts $!.message
            Pike::TaskPropertyValue.collection.indexes.drop rescue puts $!.message

            Pike::Work.collection.indexes.drop rescue puts $!.message

            Pike::Introduction.collection.indexes.drop rescue puts $!.message
            Pike::Friendship.collection.indexes.drop rescue puts $!.message

            Pike::System::Message.collection.indexes.drop rescue puts $!.message
            Pike::System::MessageState.collection.indexes.drop rescue puts $!.message

            Pike::System::Action.collection.indexes.drop rescue puts $!.message

            Pike::System::Migration.collection.indexes.drop rescue puts $!.message

          end
        end
      end

      desc 'Create all indexes'
      task :re_create_indexes, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do

            Pike::User.collection.indexes.create({:_url   => 1,
                                                  :_name  => 1}, :name => 'url')
            Pike::User.collection.indexes.create({:_name  => 1,
                                                  :_url   => 1}, :name => 'name')

            Pike::System::Identity.collection.indexes.create({:expires_at => 1,
                                                              :created_at => -1}, :name => 'expires_at')
            Pike::System::Identity.collection.indexes.create({:value      => 1,
                                                              :expires_at => 1,
                                                              :created_at => -1}, :name => 'value')

            Pike::Property.collection.indexes.create({:user_id    => 1,
                                                      :type       => 1,
                                                      :_name      => 1,
                                                      :copy_of_id => 1}, :name => 'user')
            Pike::Property.collection.indexes.create({:copy_of_id => 1,
                                                      :user_id    => 1,
                                                      :type       => 1,
                                                      :_name      => 1}, :name => 'copy_of')

            Pike::PropertyValue.collection.indexes.create({:_type       => 1,
                                                           :property_id => 1}, :name => 'property')

            Pike::Project.collection.indexes.create({:user_id     => 1,
                                                     :_name       => 1,
                                                     :is_shared   => 1,
                                                     :copy_of_id  => 1}, :name => 'user')
            Pike::Project.collection.indexes.create({:copy_of_id  => 1,
                                                     :user_id     => 1,
                                                     :_name       => 1}, :name => 'copy_of')

            Pike::ProjectPropertyValue.collection.indexes.create({:_type        => 1,
                                                                  :project_id   => 1,
                                                                  :property_id  => 1,
                                                                  :copy_of_id   => 1}, :name => 'project')
            Pike::ProjectPropertyValue.collection.indexes.create({:_type        => 1,
                                                                  :copy_of_id   => 1}, :name => 'copy_of')

            Pike::Activity.collection.indexes.create({:user_id    => 1,
                                                      :_name      => 1,
                                                      :is_shared  => 1,
                                                      :copy_of_id => 1}, :name => 'user')
            Pike::Activity.collection.indexes.create({:copy_of_id => 1,
                                                      :user_id    => 1,
                                                      :_name      => 1}, :name => 'copy_of')

            Pike::ActivityPropertyValue.collection.indexes.create({:_type       => 1,
                                                                   :activity_id => 1,
                                                                   :property_id => 1,
                                                                   :copy_of_id  => 1}, :name => 'activity')
            Pike::ActivityPropertyValue.collection.indexes.create({:_type       => 1,
                                                                   :copy_of_id  => 1}, :name => 'copy_of')

            Pike::Task.collection.indexes.create({:user_id        => 1,
                                                  :flag           => 1,
                                                  :project_id     => 1,
                                                  :_project_name  => 1,
                                                  :activity_id    => 1,
                                                  :_activity_name => 1}, :name => 'user')
            Pike::Task.collection.indexes.create({:project_id     => 1,
                                                  :flag           => 1,
                                                  :_project_name  => 1,
                                                  :_activity_name => 1}, :name => 'project')
            Pike::Task.collection.indexes.create({:activity_id    => 1,
                                                  :flag           => 1,
                                                  :_project_name  => 1,
                                                  :_activity_name => 1}, :name => 'activity')

            Pike::TaskPropertyValue.collection.indexes.create({:_type       => 1,
                                                               :task_id     => 1,
                                                               :property_id => 1}, :name => 'task')

            Pike::Work.collection.indexes.create({:user_id        => 1,
                                                  :task_id        => 1,
                                                  :date           => 1,
                                                  :_project_name  => 1,
                                                  :_activity_name => 1,
                                                  :is_started     => 1}, :name => 'user')

            Pike::Work.collection.indexes.create({:task_id        => 1,
                                                  :date           => 1,
                                                  :_project_name  => 1,
                                                  :_activity_name => 1}, :name => 'task')

            Pike::Introduction.collection.indexes.create({:user_target_id   => 1,
                                                          :_user_source_url => 1}, :name => 'user')

            Pike::Friendship.collection.indexes.create({:user_source_id   => 1,
                                                        :user_target_id   => 1,
                                                        :_user_target_url => 1}, :name => 'user')

            Pike::System::Message.collection.indexes.create({:created_at => 1}, :name => 'created_at')

            Pike::System::MessageState.collection.indexes.create({:user_id    => 1,
                                                                  :message_id  => 1,
                                                                  :state       => 1,
                                                                  :created_at  => 1}, :name => 'user')

            Pike::System::Action.collection.indexes.create({:state => 1,
                                                            :index => 1}, :name => 'state')
            Pike::System::Action.collection.indexes.create({:index => 1}, :name => 'index')

            Pike::System::Migration.collection.indexes.create({:name => 1}, :name   => 'name',
                                                                            :unique => true)

          end
        end
      end

      desc 'Add the message for Version 0.5.141'
      task :add_message_0_5_141, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.141'
            body = <<-MESSAGE
Changes in this version ...

* The work list is automatically scrolled if the started task is not visible.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.143'
      task :add_message_0_5_143, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.143'
            body = <<-MESSAGE
Changes in this version ...

* The sender address of exported summaries is now virtualpatterns@outlook.com instead of virtualpatterns@sympatico.ca.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Add the message for Version 0.5.144'
      task :add_message_0_5_144, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.144'
            body = <<-MESSAGE
Changes in this version ...

* The sender address of exported summaries has changed again.  It is now pike@virtualpatterns.com instead of virtualpatterns@outlook.com.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Re-destroy all work where the task has been destroyed'
      task :re_destroy_work_where_task_destroyed, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Rake::Task['pike:data:migrate:destroy_work_where_task_destroyed'].execute([true])
          end
        end
      end

      desc 'Add the message for Version 0.5.146'
      task :add_message_0_5_146, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.146'
            body = <<-MESSAGE
Changes in this version ...

* Resolved an issue deleting started tasks.

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Create Pike::User search index'
      task :create_user_search_index, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Pike::User.collection.indexes.create({:_id    => 1,
                                                  :_name  => 1}, :name => 'search')
          end
        end
      end

      desc 'Add the message for Version 0.5.169'
      task :add_message_0_5_169, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.5.169'
            body = <<-MESSAGE
Changes in this version ...

* When adding friends users are matched by the start of their name only (e.g. a search string of Joe 
  will match the user with name Joel Smith but not the user with name Mary Joeb)

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Rename the Pike::User#url property Pike::User#uri'
      task :rename_user_url_uri, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do

            Pike::User.collection.indexes.drop

            Pike::User.update_all('$rename' => {'url' => 'uri'})
            Pike::User.update_all('$rename' => {'_url' => '_uri'})

            Pike::User.collection.indexes.create({:_uri   => 1,
                                                  :_name  => 1}, :name => 'uri')
            Pike::User.collection.indexes.create({:_name  => 1,
                                                  :_uri   => 1}, :name => 'name')
            Pike::User.collection.indexes.create({:_id    => 1,
                                                  :_name  => 1}, :name => 'search')

            Pike::Introduction.collection.indexes.drop

            Pike::Introduction.update_all('$rename' => {'_user_target_url' => '_user_target_uri'})

            Pike::Introduction.collection.indexes.create({:user_target_id   => 1,
                                                          :_user_source_uri => 1}, :name => 'user')

            Pike::Friendship.collection.indexes.drop

            Pike::Friendship.update_all('$rename' => {'_user_target_url' => '_user_target_uri'})

            Pike::Friendship.collection.indexes.create({:user_source_id   => 1,
                                                        :user_target_id   => 1,
                                                        :_user_target_uri => 1}, :name => 'user')


          end
        end
      end

      desc 'Rename the message_state collection system_message_state'
      task :rename_message_state_system_message_state, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Mongoid.default_session.with(:database => 'admin').command(:renameCollection  => 'pike.message_states', 
                                                                       :to                => 'pike.system_message_states', 
                                                                       :dropTarget        => true) rescue puts $!.message
          end
        end
      end

      desc 'Add the message for Version 0.6.0'
      task :add_message_0_6_0, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            subject = 'Version 0.6.0'
            body = <<-MESSAGE
Changes in this version ...

* Upgraded to Ruby 1.9

            MESSAGE
            Pike::System::Message.create_message!(subject, body)
          end
        end
      end

      desc 'Delete the pike_system_sequences collection'
      task :remove_pike_system_sequences_collection, :force do |task, arguments|
        Pike::Application.create_context! do
          Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
            Mongoid.default_session['pike_system_sequences'].drop rescue puts $!.message
          end
        end
      end

      # Next migration ...
      # desc '(description)'
      # task :name, :force do |task, arguments|
      #   Pike::Application.create_context! do
      #     Pike::System::Migration.run(task, arguments.force ? arguments.force.to_b : false) do
      #       ...
      #     end
      #   end
      # end

    end

  end

end
