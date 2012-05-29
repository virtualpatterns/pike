require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/activity_select_page'
      require 'pike/elements/pages/flag_select_page'
      require 'pike/elements/pages/project_select_page'

      class TaskPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @task.save!
              self.hide(event)
            end
          end

          @project_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @project_link.clicked do |element, event|
            page = Pike::Elements::Pages::ProjectSelectPage.new(@task)
            page.removed do |element, _event|
              if @task.project
                _event.update_text("##{@project_link.element_id} span", @task.project.name)
                _event.remove_class("##{@project_link.element_id} span", 'ui-disabled')
              else
                _event.update_text("##{@project_link.element_id} span", 'tap to select a project')
                _event.add_class("##{@project_link.element_id} span", 'ui-disabled')
              end
            end
            page.show(event)
          end

          @activity_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @activity_link.clicked do |element, event|
            page = Pike::Elements::Pages::ActivitySelectPage.new(@task)
            page.removed do |element, _event|
              if @task.activity
                _event.update_text("##{@activity_link.element_id} span", @task.activity.name)
                _event.remove_class("##{@activity_link.element_id} span", 'ui-disabled')
              else
                _event.update_text("##{@activity_link.element_id} span", 'tap to select an activity')
                _event.add_class("##{@activity_link.element_id} span", 'ui-disabled')
              end
            end
            page.show(event)
          end

          @flag_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @flag_link.clicked do |element, event|
            page = Pike::Elements::Pages::FlagSelectPage.new(@task)
            page.removed do |element, _event|
              _event.update_text("##{@flag_link.element_id} span", Pike::Task::FLAG_NAMES[@task.flag])
            end
            page.show(event)
          end

          @properties = Pike::Elements::Properties.new(:task_properties, @task)

        end

      end

    end

  end

end
