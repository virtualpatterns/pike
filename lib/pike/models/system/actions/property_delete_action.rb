require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/property_synchronize_action'

      class PropertyDeleteAction < Pike::System::Actions::PropertySynchronizeAction

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user_source.uri=#{self.user_source ? self.user_source.uri.inspect : '(nil)'} self.user_target.uri=#{self.user_target ? self.user_target.uri.inspect : '(nil)'} self.property.name=#{self.property ? self.property.name.inspect : '(nil)'}") do
            self.delete_property(self.property)
          end
        end

      end

    end

  end

end
