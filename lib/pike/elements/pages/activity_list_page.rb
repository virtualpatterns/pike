require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/activity_page'

      class ActivityListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @activity_list = Pike::Elements::ActivityList.new
          @activity_list.item_clicked do |element, event|
            if event.item.is_a?(Pike::Elements::ActivityList::ActivityListAddItem)
              page = Pike::Elements::Pages::ActivityPage.new(Pike::Session.identity.user.activities.new)
              page.removed do |element, _event|
                _event.update_element(@activity_list)
              end
              page.show(event)
            else
              page = Pike::Elements::Pages::ActivityPage.new(event.item.activity)
              page.removed do |element, _event|
                _event.update_element(@activity_list)
              end
              page.show(event)
            end
          end

        end

      end

    end

  end

end
