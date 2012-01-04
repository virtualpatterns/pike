require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/link'
require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/activity_select_page'
      require 'pike/elements/pages/flag_select_page'
      require 'pike/elements/pages/project_select_page'
      require 'pike/elements/pages/properties_page'
      require 'pike/elements/pages/task_property_page'
      require 'pike/session'

      class TaskPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @user = Pike::Session.identity.user
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

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::TaskPropertyPage.new(@task))
            event.refresh
          end

        end

        def render(format)
          if format == :html
            @property_links = {}
            @user.task_properties.each do |property|
              property_link = RubyApp::Elements::Link.new
              property_link.clicked do |element, event|
                Pike::Session.pages.push(Pike::Elements::Pages::TaskPropertyPage.new(@task, property))
                event.refresh
              end
              @property_links[property] = property_link
            end
          end
          super(format)
        end

      end

    end

  end

end
