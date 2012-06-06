require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/friendship_page'
      require 'pike/elements/pages/introduction_edit_page'
      require 'pike/elements/pages/introduction_view_page'

      class FriendshipListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @friendship_list = Pike::Elements::FriendshipList.new
          @friendship_list.item_clicked do |element, event|
            if event.item.is_a?(Pike::Elements::FriendshipList::FriendshipListIntroductionItem)
              page = Pike::Elements::Pages::IntroductionViewPage.new(event.item.introduction)
              page.removed do |element, _event|
                _event.update_element(@friendship_list)
              end
              page.show(event)
            elsif event.item.is_a?(Pike::Elements::FriendshipList::FriendshipListAddFriendshipItem)
              page = Pike::Elements::Pages::IntroductionEditPage.new(Pike::Session.identity.user.introductions_as_source.new)
              page.removed do |element, _event|
                _event.update_element(@friendship_list)
              end
              page.show(event)
            else
              page = Pike::Elements::Pages::FriendshipPage.new(event.item.friendship)
              page.removed do |element, _event|
                _event.update_element(@friendship_list)
              end
              page.show(event)
            end
          end

        end

      end

    end

  end

end
