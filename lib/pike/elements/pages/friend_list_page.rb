require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/markdown'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/friend_list'
      require 'pike/elements/introduction_list'
      require 'pike/elements/pages/blank_page'
      #require 'pike/elements/pages/friend_page'
      require 'pike/elements/pages/introduction_page'
      require 'pike/session'

      class FriendListPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::IntroductionPage.new(Pike::Session.identity.user.introductions_to.new))
            event.refresh
          end

          @introduction_list = Pike::Elements::IntroductionList.new
          @introduction_list.clicked do |element, event|
            #Pike::Session.pages.push(Pike::Elements::Pages::IntroductionActionPage.new(event.item))
            event.refresh
          end

          @friend_list = Pike::Elements::FriendList.new
          @friend_list.clicked do |element, event|
            #Pike::Session.pages.push(Pike::Elements::Pages::FriendPage.new(event.item))
            event.refresh
          end

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_friend'
                Pike::Session.pages.push(Pike::Elements::Pages::IntroductionPage.new(Pike::Session.identity.user.introductions_to.new))
                event.refresh
            end
          end

        end

      end

    end

  end

end
