require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/project_page'

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

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_project'
                Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new))
                event.refresh
            end
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
