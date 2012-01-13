require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ActivityObserver < Mongoid::Observer
        observe Pike::Activity

        def around_save(activity)
          RubyApp::Log.debug("#{self.class}##{__method__} activity.name=#{activity.name.inspect}")
          create_action = ( activity.name_changed? || activity.is_shared_changed? ) ? true : false
          yield
          Pike::System::Actions::ActivityAction.create!(:user_source => activity.user,
                                                        :user_target => nil,
                                                        :action => Pike::System::Action::ACTION_SYNC,
                                                        :activity => activity) if create_action unless activity.copy_of
        end

        def around_destroy(activity)
          RubyApp::Log.debug("#{self.class}##{__method__} activity.name=#{activity.name.inspect}")
          _activities = activity.copies.collect
          yield
          _activities.each do |_activity|
            Pike::System::Actions::ActivityAction.create!(:user_source => nil,
                                                          :user_target => nil,
                                                          :action => Pike::System::Action::ACTION_DELETE,
                                                          :activity => _activity)
          end
        end

      end

    end

  end

end
