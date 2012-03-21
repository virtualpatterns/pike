require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ActivitySynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :activity, :class_name => 'Pike::Activity'

        def delete_activity(activity)
          RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} activity.name=#{activity.name.inspect}")
          activity.tasks.each do |task|
            task.destroy
          end
          activity.destroy
        end

      end

    end

  end

end
