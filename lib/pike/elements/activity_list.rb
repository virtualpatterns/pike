require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/activity_page'

    class ActivityList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class ActivityListAddItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class ActivityListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :activity :item

        def initialize(activity)
          super(activity)
        self.attributes.merge!('class' => 'activity-list-item')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.attributes.merge!('class'      => 'activity-list',
                               'data-theme' => 'd')

        self.item_clicked do |element, event|
          if event.item.is_a?(Pike::Elements::ActivityList::ActivityListAddItem)
            page = Pike::Elements::Pages::ActivityPage.new(Pike::Session.identity.user.activities.new)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          else
            page = Pike::Elements::Pages::ActivityPage.new(event.item.activity)
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
          self.items.push(Pike::Elements::ActivityList::ActivityListAddItem.new)
          Pike::Session.identity.user.activities.all.each do |activity|
            self.items.push(Pike::Elements::ActivityList::ActivityListItem.new(activity))
          end
        end
        super(format)
      end

    end

  end

end
