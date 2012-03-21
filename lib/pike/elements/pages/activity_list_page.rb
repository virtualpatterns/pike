require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/activity_page'

      class ActivityListPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
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

          @activity_list = Pike::Elements::ActivityList.new
          @activity_list.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivityPage.new(event.item))
            event.refresh
          end

        end

      end

    end

  end

end
