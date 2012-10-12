require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/activity_property_value_synchronize_action'

      class ActivityPropertyValueDeleteAction < Pike::System::Actions::ActivityPropertyValueSynchronizeAction

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.value.property.name=#{self.value ? self.value.property.name.inspect : '(nil)'}  self.value.value=#{self.value ? self.value.value.inspect : '(nil)'}") do
            self.delete_value(self.value)
          end
        end

      end

    end

  end

end
