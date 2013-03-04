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
          if activity.changes.include?('name') ||
             activity.changes.include?('is_shared')      
            yield
            Pike::System::Actions::ActivityCopyAction.create!(:user_source => activity.user,
                                                              :user_target => nil,
                                                              :activity => activity) unless activity.copy?
          else
            yield
          end
          return true
        end

        def around_destroy(activity)
          _activities = activity.copies.all.collect
          yield
          _activities.each do |_activity|
            Pike::System::Actions::ActivityDeleteAction.create!(:user_source => nil,
                                                                :user_target => nil,
                                                                :activity => _activity)
          end
          return true
        end

      end

    end

  end

end
