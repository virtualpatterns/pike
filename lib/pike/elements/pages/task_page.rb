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
      require 'pike/elements/pages/properties_page'

      class TaskPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              task.save!
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @project_link = RubyApp::Elements::Link.new
          @project_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectSelectPage.new(@task))
            event.refresh
          end

          @activity_link = RubyApp::Elements::Link.new
          @activity_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivitySelectPage.new(@task))
            event.refresh
          end

          @flag_link = RubyApp::Elements::Link.new
          @flag_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::FlagSelectPage.new(@task))
            event.refresh
          end

          @properties = Pike::Elements::Properties.new(:task_properties, @task)

        end

      end

    end

  end

end
