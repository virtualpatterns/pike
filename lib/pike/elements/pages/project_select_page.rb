module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/select_page'
      require 'pike/elements/project_select'
      require 'pike/session'

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
