require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/action'

      class MessageStateCreateAction < Pike::System::Action

        belongs_to :message, :class_name => 'Pike::System::Message'

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.message.subject=#{self.message.subject.inspect}") do
            Pike::User.all.each do |user|
              message_state = user.message_states.where_message(self.message).first || user.message_states.create!(:message => self.message)
              message_state.state = Pike::System::MessageState::STATE_NEW
              message_state.save!
            end
          end
        end

      end

    end

  end

end
