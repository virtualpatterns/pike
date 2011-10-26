module Pike

  module Elements

    module Pages
      require 'elements/pages/select_page'
      require 'elements/project_select'
      require 'session'

      class ProjectSelectPage < Pike::Elements::Pages::SelectPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @project_select = Pike::Elements::ProjectSelect.new
          @project_select.selected_item = @task.project
          @project_select.selected do |element, event|
            @task.project = @project_select.selected_item
            Pike::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
