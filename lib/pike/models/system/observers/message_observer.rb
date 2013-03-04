require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class MessageObserver < Mongoid::Observer
        observe Pike::System::Message

        def after_save(message)
          Pike::System::Actions::MessageStateCreateAction.create!(:message => message)
          return true
        end

      end

    end

  end

end
