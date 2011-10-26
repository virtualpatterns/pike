require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'elements/pages/blank_page'
      require 'elements/pages/project_page'
      require 'elements/project_list'
      require 'session'

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

        end

      end

    end

  end

end
