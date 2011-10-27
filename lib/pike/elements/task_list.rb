require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/list'

module Pike

  module Elements
    require 'pike/elements/pages/task_page'
    require 'pike/models'
    require 'pike/session'

    class TaskList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.selected do |element, event|
          Pike::Session.pages.push(Pike::Elements::Pages::TaskPage.new(event.item))
          event.refresh
        end

      end

      def render(format)
        self.items = Pike::Session.identity.user.tasks.where_not_flag(Pike::Task::FLAG_FIXED).all if format == :html
        @flag = nil
        super(format)
      end

    end

  end

end
