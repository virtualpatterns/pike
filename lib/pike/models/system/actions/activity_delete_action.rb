require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/activity_synchronize_action'

      class ActivityDeleteAction < Pike::System::Actions::ActivitySynchronizeAction

        def process!
          RubyApp::Log.debug("#{self.class}##{__method__} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.activity.name=#{self.activity ? self.activity.name.inspect : '(nil)'}")
          # Delete
          self.delete_activity(self.activity)
          self.destroy
        end

      end

    end

  end

end
