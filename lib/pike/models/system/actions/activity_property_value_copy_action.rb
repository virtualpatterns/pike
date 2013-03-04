require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/activity_property_value_synchronize_action'

      class ActivityPropertyValueCopyAction < Pike::System::Actions::ActivityPropertyValueSynchronizeAction

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user_source.uri=#{self.user_source ? self.user_source.uri.inspect : '(nil)'} self.user_target.uri=#{self.user_target ? self.user_target.uri.inspect : '(nil)'} self.value.property.name=#{self.value ? self.value.property.name.inspect : '(nil)'}  self.value.value=#{self.value ? self.value.value.inspect : '(nil)'}") do
            unless self.user_target
              # Sync to all friends
              self.user_source.friendships_as_source.all.each do |friendship|
                unless self.value
                  # Sync all shared values to a friend ... never a scenario
                  #self.sync_shared_values_to_friend(friendship.user_target)
                else
                  # Sync a specific value to a friend
                  self.sync_value_to_friend(self.value, friendship.user_target)
                end
              end
            else
              # Sync to a specific user
              if self.user_source.friendships_as_source.where_user_target(self.user_target).exists?
                # Sync to a friend
                unless self.value
                  # Sync all shared values to a friend
                  self.sync_shared_values_to_friend(self.user_target)
                else
                  # Sync a specific value to a friend ... never a scenario
                  #self.sync_value_to_friend(self.value, self.user_target)
                end
              else
                # Sync all shared values to a non-friend
                self.sync_shared_values_to_non_friend(self.user_target)
              end
            end
          end
        end

        def sync_shared_values_to_friend(user)
          self.user_source.activities.where_shared.each do |activity|
            activity.values.all.each do |value|
              self.sync_value_to_friend(value, user)
            end
          end
        end

        def sync_value_to_friend(value, user)
          if value.activity.shared?
            # Add or update the friend's value
            self.add_update_value_to_user(value, user)
          else
            # Delete the friend's value
            self.delete_value_from_user(value, user)
          end
        end

        def sync_shared_values_to_non_friend(user)
          self.user_source.activities.where_shared.each do |activity|
            activity.values.all.each do |value|
              self.sync_value_to_non_friend(value, user)
            end
          end
        end

        def sync_value_to_non_friend(value, user)
          self.delete_value_from_user(value, user)
        end

        def add_update_value_to_user(value, user)
          user.activities.where_copy_of(value.activity).each do |activity|
            values = activity.values.where_copy_of(value)
            unless values.exists?
              self.add_value_to_user(value, user)
            else
              values.each do |_value|
                self.update_value(value, _value)
              end
            end
          end
        end

        def add_value_to_user(value, user)
          user.activities.where_copy_of(value.activity).each do |activity|
            user.properties.where_copy_of(value.property).each do |property|
              activity.values.create!(:copy_of => value,
                                      :property => property,
                                      :value => value.value)
            end
          end
        end

        def update_value(value, _value)
          _value.value = value.value
          _value.save!
        end

        def delete_value_from_user(value, user)
          user.activities.where_copy_of(value.activity).each do |activity|
            activity.values.where_copy_of(value).each do |_value|
              self.delete_value(_value)
            end
          end
        end

      end

    end

  end

end
