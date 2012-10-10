require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/property_synchronize_action'

      class PropertyCopyAction < Pike::System::Actions::PropertySynchronizeAction

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.property.name=#{self.property ? self.property.name.inspect : '(nil)'}") do
            unless self.user_target
              # Sync to all friends
              # TODO ... index user.friendships_as_source.all
              self.user_source.friendships_as_source.all.each do |friendship|
                unless self.property
                  # Sync all properties to a friend ... never a scenario
                  #self.sync_properties_to_friend(friendship.user_target)
                else
                  # Sync a specific property to a friend
                  self.add_update_property_to_user(self.property, friendship.user_target)
                end
              end
            else
              # Sync to a specific user
              # TODO ... index user.friendships_as_source.where_user_target
              if self.user_source.friendships_as_source.where_user_target(self.user_target).exists?
                # Sync to a friend
                unless self.property
                  # Sync all properties to a friend
                  self.sync_properties_to_friend(self.user_target)
                else
                  # Sync a specific property to a friend ... never a scenario
                  #self.sync_property_to_friend(self.property, self.user_target)
                end
              else
                # Sync all properties to a non-friend
                self.sync_properties_to_non_friend(self.user_target)
              end
            end
          end
        end

        def sync_properties_to_friend(user)
          # TODO ... index user.properties.where_not_copy
          self.user_source.properties.where_not_copy.each do |property|
            self.add_update_property_to_user(property, user)
          end
        end

        def sync_properties_to_non_friend(user)
          # TODO ... index user.properties.where_not_copy
          self.user_source.properties.where_not_copy.each do |property|
            self.sync_property_to_non_friend(property, user)
          end
        end

        def sync_property_to_non_friend(property, user)
          self.delete_property_from_user(property, user)
        end

        def add_update_property_to_user(property, user)
          # TODO ... index user.properties.where_copy_of
          properties = user.properties.where_copy_of(property)
          unless properties.exists?
            self.add_property_to_user(property, user)
          else
            properties.each do |_property|
              self.update_property(property, _property)
            end
          end
        end

        def add_property_to_user(property, user)
          user.properties.create!(:copy_of => property,
                                  :type => property.type,
                                  :name => property.name)
        end

        def update_property(property, _property)
          _property.type = property.type
          _property.name = property.name
          _property.save!
        end

        def delete_property_from_user(property, user)
          # TODO ... index user.properties.where_copy_of
          user.properties.where_copy_of(property).each do |_property|
            self.delete_property(_property)
          end
        end

      end

    end

  end

end
