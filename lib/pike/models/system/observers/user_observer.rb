require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app/log'

module Pike

  module System

    module Observers
      require 'pike/models'

      class UserObserver < Mongoid::Observer
        observe Pike::User

        #def after_initialize(user)
        #  # Called on Pike::User#new
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def before_validation(user)
        #  # Called on Pike::User#save!
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def after_validation(user)
        #  # Called on Pike::User#save!
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def before_create(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def after_create(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def before_update(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def after_update(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def before_save(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user.url=#{user.url.inspect} user._friend_ids_change=#{user._friend_ids_change.inspect}")
        #end

        #def after_save(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def before_destroy(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

        #def after_destroy(user)
        #  RubyApp::Log.debug("#{self.class}##{__method__} user=#{user.inspect}")
        #end

      end

    end

  end

end
