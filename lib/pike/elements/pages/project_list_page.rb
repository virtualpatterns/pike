require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/project_page'
      require 'pike/elements/project_list'
      require 'pike/session'

      class ProjectListPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new))
            event.refresh
          end

          @project_list = Pike::Elements::ProjectList.new
          @project_list.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(event.item))
            event.refresh
          end

        end

      end

    end

  end

end
