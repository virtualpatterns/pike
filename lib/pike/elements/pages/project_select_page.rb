require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/project_page'

      class ProjectSelectPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @back_button = Pike::Elements::Navigation::BackButton.new

          @project_select = Pike::Elements::ProjectSelect.new(@task)
          @project_select.item_clicked do |element, event|
            if event.item.is_a?(Pike::Elements::ProjectSelect::ProjectSelectAddItem)
              page = Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new)
              page.removed do |element, _event|
                _event.update_element(@project_select)
              end
              page.show(event)
            else
              @task.project = event.item.project
              self.hide(event)
            end
          end

        end

      end

    end

  end

end
