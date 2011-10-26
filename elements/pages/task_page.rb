require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/link'

module Pike

  module Elements

    module Pages
      require 'elements/pages/properties_page'
      require 'elements/pages/project_select_page'
      require 'elements/pages/activity_select_page'
      require 'elements/pages/flag_select_page'
      require 'session'

      class TaskPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super(task)

          @task = task

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

        end

      end

    end

  end

end
