require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'

module Pike

  module Elements

    module Pages
      require 'pike/session'
      require 'pike/elements/pages/select_page'
      require 'pike/elements/activity_select'

      class ActivitySelectPage < Pike::Elements::Pages::SelectPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @activity_select = Pike::Elements::ActivitySelect.new
          @activity_select.selected_item = @task.activity
          @activity_select.selected do |element, event|
            @task.activity = @activity_select.selected_item
            Pike::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
