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
          activity.tasks.all.each do |task|
            task.destroy
          end
          activity.destroy
        end

      end

    end

  end

end
