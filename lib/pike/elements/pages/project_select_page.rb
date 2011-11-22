require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/markdown'
require 'ruby_app/elements/button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/project_list_page'
      require 'pike/elements/pages/project_page'
      require 'pike/elements/pages/select_page'
      require 'pike/elements/project_select'
      require 'pike/session'

      class ProjectSelectPage < Pike::Elements::Pages::SelectPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @list_project_button = RubyApp::Elements::Button.new
          @list_project_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectListPage.new)
            event.refresh
          end

          @add_project_button = RubyApp::Elements::Button.new
          @add_project_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new))
            event.refresh
          end

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_project'
                Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new))
                event.refresh
            end
          end

          @project_select = Pike::Elements::ProjectSelect.new
          @project_select.selected_item = @task.project
          @project_select.clicked do |element, event|
            @task.project = @project_select.selected_item
            Pike::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
