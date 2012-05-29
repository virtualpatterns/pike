require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

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
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.attributes.merge!('data-theme' => 'd')
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
