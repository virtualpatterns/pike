require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class FlagSelect < RubyApp::Elements::Mobile::List

      class FlagSelectItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        alias :flag :item

        def initialize(flag)
          super(flag)
        end

      end

      class FlagSelectedItem < Pike::Elements::FlagSelect::FlagSelectItem

        template_path(:all, File.dirname(__FILE__))

        alias :flag :item

        def initialize(flag)
          super(flag)
          self.attributes.merge!('data-icon' => 'check')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize(task)
        super()

        @task = task

        self.attributes.merge!('data-theme' => 'd')

        self.item_clicked do |element, event|
          @task.flag = event.item.flag
          Pike::Session.document.page.hide(event)
        end

      end

      def render(format)
        self.items = [Pike::Task::FLAG_LIKED,
                      Pike::Task::FLAG_NORMAL,
                      Pike::Task::FLAG_COMPLETED].collect { |flag| flag == @task.flag ?  Pike::Elements::FlagSelect::FlagSelectedItem.new(flag) : Pike::Elements::FlagSelect::FlagSelectItem.new(flag) } if format == :html
        super(format)
      end

    end

  end

end
