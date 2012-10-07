require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/project_page'

    class ProjectList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class ProjectListAddItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class ProjectListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :project :item

        def initialize(project)
          super(project)
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.attributes.merge!('data-theme' => 'd')

        self.item_clicked do |element, event|
          if event.item.is_a?(Pike::Elements::ProjectList::ProjectListAddItem)
            page = Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          else
            page = Pike::Elements::Pages::ProjectPage.new(event.item.project)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          end
        end

      end

      def render(format)
        if format == :html
          self.items.clear
          self.items.push(Pike::Elements::ProjectList::ProjectListAddItem.new)
          Pike::Session.identity.user.projects.all.each do |project|
            self.items.push(Pike::Elements::ProjectList::ProjectListItem.new(project))
          end
        end
        super(format)
      end

    end

  end

end
