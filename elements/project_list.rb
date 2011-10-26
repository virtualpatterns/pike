require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/list'

module Pike

  module Elements
    require 'elements/pages/project_page'
    require 'session'

    class ProjectList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.selected do |element, event|
          Pike::Session.pages.push(Pike::Elements::Pages::ProjectPage.new(event.item))
          event.refresh
        end

      end

      def render(format)
        self.items = Pike::Session.identity.user.projects.all if format == :html
        super(format)
      end

    end

  end

end
