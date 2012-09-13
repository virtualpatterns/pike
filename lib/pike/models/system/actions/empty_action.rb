require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike'

      class EmptyAction < Pike::System::Action

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)}") do
            raise 'Empty Action'
          end
        end

      end

    end

  end

end
