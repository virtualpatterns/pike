require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class MessageObserver < Mongoid::Observer
        observe Pike::System::Message

        def around_save(message)
          create_action = ( message.subject_changed? || message.body_changed? )
          yield
          Pike::System::Actions::MessageStateCreateAction.create!(:message => message) if create_action
        end

      end

    end

  end

end
