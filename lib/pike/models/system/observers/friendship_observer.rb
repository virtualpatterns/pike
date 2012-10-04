require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app'

module Pike

  module System

    module Observers
      require 'pike/models'

      class FriendshipObserver < Mongoid::Observer
        observe Pike::Friendship

        def after_save(friendship)
          Pike::System::Actions::PropertyCopyAction.create!(:user_source => friendship.user_source,
                                                            :user_target => friendship.user_target,
                                                            :property => nil)
          Pike::System::Actions::ProjectCopyAction.create!(:user_source => friendship.user_source,
                                                           :user_target => friendship.user_target,
                                                           :project => nil)
          Pike::System::Actions::ProjectPropertyValueCopyAction.create!(:user_source => friendship.user_source,
                                                                        :user_target => friendship.user_target,
                                                                        :value => nil)
          Pike::System::Actions::ActivityCopyAction.create!(:user_source => friendship.user_source,
                                                            :user_target => friendship.user_target,
                                                            :project => nil)
        end

        def after_destroy(friendship)
          Pike::System::Actions::ActivityCopyAction.create!(:user_source => friendship.user_source,
                                                            :user_target => friendship.user_target,
                                                            :project => nil)
          Pike::System::Actions::ProjectPropertyValueCopyAction.create!(:user_source => friendship.user_source,
                                                                        :user_target => friendship.user_target,
                                                                        :value => nil)
          Pike::System::Actions::ProjectCopyAction.create!(:user_source => friendship.user_source,
                                                           :user_target => friendship.user_target,
                                                           :project => nil)
          Pike::System::Actions::PropertyCopyAction.create!(:user_source => friendship.user_source,
                                                            :user_target => friendship.user_target,
                                                            :property => nil)
        end

      end

    end

  end

end
