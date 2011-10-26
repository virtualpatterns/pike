require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'elements/pages/blank_page'
      require 'elements/pages/task_page'
      require 'elements/task_list'
      require 'session'

      class TaskListPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::TaskPage.new(Pike::Session.identity.user.tasks.new))
            event.refresh
          end

          @task_list = Pike::Elements::TaskList.new

        end

      end

    end

  end

end
