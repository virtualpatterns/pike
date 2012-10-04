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
          create_action = ( activity.name_changed? || activity.is_shared_changed? )
          yield
          Pike::System::Actions::ActivityCopyAction.create!(:user_source => activity.user,
                                                            :user_target => nil,
                                                            :activity => activity) if create_action unless activity.copy_of
        end

        def around_destroy(activity)
          # TODO ... index activity.copies.all
          _activities = activity.copies.all.collect
          yield
          _activities.each do |_activity|
            Pike::System::Actions::ActivityDeleteAction.create!(:user_source => nil,
                                                                :user_target => nil,
                                                                :activity => _activity)
          end
        end

      end

    end

  end

end
