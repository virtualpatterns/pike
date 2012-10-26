module Pike

  module System

    module Actions
      require 'pike/models/task'
      require 'pike/models/system/actions/synchronize_action'

      class ProjectSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :project, :class_name => 'Pike::Project'

        def delete_project(project)
          Pike::Task.destroy_all(:project_id => project.id)
          project.destroy
        end

      end

    end

  end

end
