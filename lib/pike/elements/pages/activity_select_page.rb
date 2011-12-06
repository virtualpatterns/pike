require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/markdown'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/activity_page'
      require 'pike/elements/pages/select_page'
      require 'pike/elements/activity_select'
      require 'pike/session'

      class ActivitySelectPage < Pike::Elements::Pages::SelectPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @add_activity_button = RubyApp::Elements::Button.new
          @add_activity_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivityPage.new(Pike::Session.identity.user.activities.new))
            event.refresh
          end

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_activity'
                Pike::Session.pages.push(Pike::Elements::Pages::ActivityPage.new(Pike::Session.identity.user.activities.new))
                event.refresh
            end
          end

          @activity_select = Pike::Elements::ActivitySelect.new
          @activity_select.selected_item = @task.activity
          @activity_select.clicked do |element, event|
            @task.activity = @activity_select.selected_item
            Pike::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
