require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/friend_page'
      require 'pike/elements/pages/introduction_edit_page'
      require 'pike/elements/pages/introduction_view_page'

      class FriendListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @add_button = Pike::Elements::Navigation::AddButton.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::IntroductionEditPage.new(Pike::Session.identity.user.introductions_as_source.new))
            event.refresh
          end

          @introduction_list = Pike::Elements::IntroductionList.new
          @introduction_list.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::IntroductionViewPage.new(event.item))
            event.refresh
          end

          @friend_list = Pike::Elements::FriendList.new
          @friend_list.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::FriendPage.new(event.item))
            event.refresh
          end

          @content = RubyApp::Elements::Mobile::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_friend'
                Pike::Session.pages.push(Pike::Elements::Pages::IntroductionEditPage.new(Pike::Session.identity.user.introductions_as_source.new))
                event.refresh
            end
          end

        end

      end

    end

  end

end
