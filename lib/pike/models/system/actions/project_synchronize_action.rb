require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ProjectSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :project, :class_name => 'Pike::Project'

      end

    end

  end

end
