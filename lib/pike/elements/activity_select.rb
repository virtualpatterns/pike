require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class ActivitySelect < RubyApp::Elements::Mobile::List

      class ActivitySelectAddItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class ActivitySelectItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        alias :activity :item

        def initialize(activity)
          super(activity)
        end

      end

      class ActivitySelectedItem < Pike::Elements::ActivitySelect::ActivitySelectItem

        template_path(:all, File.dirname(__FILE__))

        alias :activity :item

        def initialize(activity)
          super(activity)
          self.attributes.merge!('data-icon' => 'check')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize(task)
        super()

        @task = task

        self.attributes.merge!('data-theme' => 'd')

      end

      def render(format)
        if format == :html
          self.items.clear
          self.items.push(Pike::Elements::ActivitySelect::ActivitySelectAddItem.new)
          Pike::Session.identity.user.activities.all.each do |activity|
            self.items.push(activity == @task.activity ?  Pike::Elements::ActivitySelect::ActivitySelectedItem.new(activity) : Pike::Elements::ActivitySelect::ActivitySelectItem.new(activity))
          end
        end
        super(format)
      end

    end

  end

end
