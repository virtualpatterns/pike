require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/activity_synchronize_action'

      class ActivityCopyAction < Pike::System::Actions::ActivitySynchronizeAction

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.activity.name=#{self.activity ? self.activity.name.inspect : '(nil)'}") do
            unless self.user_target
              # Sync to all friends
              self.user_source.friendships_as_source.all.each do |friendship|
                unless self.activity
                  # Sync all shared activities to a friend ... never a scenario
                  #self.sync_shared_activities_to_friend(friendship.user_target)
                else
                  # Sync a specific activity to a friend
                  self.sync_activity_to_friend(self.activity, friendship.user_target)
                end
              end
            else
              # Sync to a specific user
              if self.user_source.friendships_as_source.where_user_target(self.user_target).exists?
                # Sync to a friend
                unless self.activity
                  # Sync all shared activities to a friend
                  self.sync_shared_activities_to_friend(self.user_target)
                else
                  # Sync a specific activity to a friend ... never a scenario
                  #self.sync_activity_to_friend(self.activity, self.user_target)
                end
              else
                # Sync all shared activities to a non-friend
                self.sync_shared_activities_to_non_friend(self.user_target)
              end
            end
          end
        end

        def sync_shared_activities_to_friend(user)
          self.user_source.activities.where_shared.each do |activity|
            self.sync_activity_to_friend(activity, user)
          end
        end

        def sync_activity_to_friend(activity, user)
          if activity.shared?
            # Add or update the friend's activity
            self.add_update_activity_to_user(activity, user)
          else
            # Delete the friend's activity
            self.delete_activity_from_user(activity, user)
          end
        end

        def sync_shared_activities_to_non_friend(user)
          self.user_source.activities.where_shared.each do |activity|
            self.sync_activity_to_non_friend(activity, user)
          end
        end

        def sync_activity_to_non_friend(activity, user)
          self.delete_activity_from_user(activity, user)
        end

        def add_update_activity_to_user(activity, user)
          activities = user.activities.where_copy_of(activity)
          unless activities.exists?
            self.add_activity_to_user(activity, user)
          else
            activities.each do |_activity|
              self.update_activity(activity, _activity)
            end
          end
        end

        def add_activity_to_user(activity, user)
          user.activities.create!(:copy_of => activity,
                                :name => activity.name,
                                :is_shared => false)
        end

        def update_activity(activity, _activity)
          _activity.name = activity.name
          _activity.save!
        end

        def delete_activity_from_user(activity, user)
          user.activities.where_copy_of(activity).each do |_activity|
            self.delete_activity(_activity)
          end
        end

      end

    end

  end

end
