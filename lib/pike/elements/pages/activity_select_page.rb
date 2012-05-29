require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/activity_page'

      class ActivitySelectPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @back_button = Pike::Elements::Navigation::BackButton.new

          @activity_select = Pike::Elements::ActivitySelect.new(@task)
          @activity_select.item_clicked do |element, event|
            if event.item.is_a?(Pike::Elements::ActivitySelect::ActivitySelectAddItem)
              page = Pike::Elements::Pages::ActivityPage.new(Pike::Session.identity.user.activities.new)
              page.removed do |element, _event|
                _event.update_element(@activity_select)
              end
              page.show(event)
            else
              @task.activity = event.item.activity
              self.hide(event)
            end
          end

        end

      end

    end

  end

end
