require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/activity_list_page'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/project_list_page'
      require 'pike/session'

      class SettingsPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @project_list_link = RubyApp::Elements::Link.new
          @project_list_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectListPage.new)
            event.refresh
          end

          @activity_list_link = RubyApp::Elements::Link.new
          @activity_list_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivityListPage.new)
            event.refresh
          end

        end

      end

    end

  end

end
