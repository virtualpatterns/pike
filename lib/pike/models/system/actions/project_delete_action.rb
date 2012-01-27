require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/project_synchronize_action'

      class ProjectDeleteAction < Pike::System::Actions::ProjectSynchronizeAction

        def process!
          RubyApp::Log.debug("#{self.class}##{__method__} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.project.name=#{self.project ? self.project.name.inspect : '(nil)'}")
          # Delete
          self.delete_project(self.project)
          self.destroy
        end

      end

    end

  end

end
