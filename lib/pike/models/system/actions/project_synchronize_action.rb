require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ProjectSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :project, :class_name => 'Pike::Project'

        def delete_project(project)
          RubyApp::Log.debug(RubyApp::Log::INFO, "ACTION #{RubyApp::Log.prefix(self, __method__)} project.name=#{project.name.inspect}")
          project.tasks.all.each do |task|
            task.destroy
          end
          project.destroy
        end

      end

    end

  end

end
