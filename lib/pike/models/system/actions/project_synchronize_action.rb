require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ProjectSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :project, :class_name => 'Pike::Project'

        def delete_project(project)
          RubyApp::Log.debug("#{self.class}##{__method__} project.name=#{project.name.inspect}")
          project.tasks.each do |task|
            task.destroy
          end
          project.destroy
        end

      end

    end

  end

end
