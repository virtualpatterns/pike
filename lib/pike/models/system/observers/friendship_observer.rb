require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app/log'

module Pike

  module System

    module Observers
      require 'pike/models'

      class FriendshipObserver < Mongoid::Observer
        observe Pike::Friendship

        #def after_initialize(friendship)
        #  # Called on Pike::Friendship#new
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def before_validation(friendship)
        #  # Called on Pike::Friendship#save!
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def after_validation(friendship)
        #  # Called on Pike::Friendship#save!
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def before_create(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def after_create(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def before_update(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def after_update(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        #def before_save(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship.url=#{friendship.url.inspect} friendship._friend_ids_change=#{friendship._friend_ids_change.inspect}")
        #end

        def after_save(friendship)
          RubyApp::Log.debug("#{self.class}##{__method__} friendship.user_source.url=#{friendship.user_source.url} friendship.user_target.url=#{friendship.user_target.url}")
          Pike::System::Actions::ProjectAction.create!(:user_source => friendship.user_source,
                                                       :user_target => friendship.user_target,
                                                       :action => Pike::System::Action::ACTION_SYNC,
                                                       :project => nil)
          Pike::System::Actions::ActivityAction.create!(:user_source => friendship.user_source,
                                                        :user_target => friendship.user_target,
                                                        :action => Pike::System::Action::ACTION_SYNC,
                                                        :project => nil)
        end

        #def before_destroy(friendship)
        #  RubyApp::Log.debug("#{self.class}##{__method__} friendship=#{friendship.inspect}")
        #end

        def after_destroy(friendship)
          RubyApp::Log.debug("#{self.class}##{__method__} friendship.user_source.url=#{friendship.user_source.url} friendship.user_target.url=#{friendship.user_target.url}")
          Pike::System::Actions::ProjectAction.create!(:user_source => friendship.user_source,
                                                       :user_target => friendship.user_target,
                                                       :action => Pike::System::Action::ACTION_SYNC,
                                                       :project => nil)
          Pike::System::Actions::ActivityAction.create!(:user_source => friendship.user_source,
                                                        :user_target => friendship.user_target,
                                                        :action => Pike::System::Action::ACTION_SYNC,
                                                        :project => nil)
        end

      end

    end

  end

end
