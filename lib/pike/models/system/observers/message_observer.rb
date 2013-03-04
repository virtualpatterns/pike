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
          if message.changes.include(:subject) ||
             message.changes.include(:body)
            yield
            Pike::System::Actions::MessageStateCreateAction.create!(:message => message)
          else
            yield
          end
          return true
        end

      end

    end

  end

end
