require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/friendship_page'
    require 'pike/elements/pages/introduction_page'
    require 'pike/elements/pages/introduction_as_source_page'
    require 'pike/elements/pages/introduction_as_target_page'

    class FriendshipList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class FriendshipListIntroductionDivider < RubyApp::Elements::Mobile::Navigation::NavigationList::ListDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize(item)
          super(item)
        end

      end

      class FriendshipListIntroductionAsSourceDivider < Pike::Elements::FriendshipList::FriendshipListIntroductionDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super('Introductions You Sent')
        end

      end

      class FriendshipListIntroductionAsTargetDivider < Pike::Elements::FriendshipList::FriendshipListIntroductionDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super('Introductions You Received')
        end

      end

      class FriendshipListIntroductionItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :introduction :item

        def initialize(introduction)
          super(introduction)
          self.attributes.merge!('class' => 'friendship-list-introduction-item')
        end

      end

      class FriendshipListIntroductionAsSourceItem < Pike::Elements::FriendshipList::FriendshipListIntroductionItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super(introduction)
        end

      end

      class FriendshipListIntroductionAsTargetItem < Pike::Elements::FriendshipList::FriendshipListIntroductionItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super(introduction)
        end

      end

      class FriendshipListFriendshipDivider < RubyApp::Elements::Mobile::Navigation::NavigationList::ListDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super('Friends')
        end

      end

      class FriendshipListAddFriendshipItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class FriendshipListFriendshipItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :friendship :item

        def initialize(friendship)
          super(friendship)
          self.attributes.merge!('class' => 'friendship-list-friendship-item')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.attributes.merge!('class'              => 'friendship-list',
                               'data-divider-theme' => 'd',
                               'data-theme'         => 'd')

        self.item_clicked do |element, event|
          if event.item.is_a?(Pike::Elements::FriendshipList::FriendshipListIntroductionAsSourceItem)
            page = Pike::Elements::Pages::IntroductionAsSourcePage.new(event.item.introduction)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          elsif event.item.is_a?(Pike::Elements::FriendshipList::FriendshipListIntroductionAsTargetItem)
            page = Pike::Elements::Pages::IntroductionAsTargetPage.new(event.item.introduction)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          elsif event.item.is_a?(Pike::Elements::FriendshipList::FriendshipListAddFriendshipItem)
            page = Pike::Elements::Pages::IntroductionPage.new(Pike::Session.identity.user.introductions_as_source.new)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          else
            page = Pike::Elements::Pages::FriendshipPage.new(event.item.friendship)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          end
        end

      end

      def render(format)
        if format == :html

          self.items.clear

          if Pike::Session.identity.user.introductions_as_source.exists?
            self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionAsSourceDivider.new)
            Pike::Session.identity.user.introductions_as_source.all.each do |introduction|
              self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionAsSourceItem.new(introduction))
            end
          end

          if Pike::Session.identity.user.introductions_as_target.exists?
            self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionAsTargetDivider.new)
            Pike::Session.identity.user.introductions_as_target.all.each do |introduction|
              self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionAsTargetItem.new(introduction))
            end
          end

          self.items.push(Pike::Elements::FriendshipList::FriendshipListFriendshipDivider.new)
          self.items.push(Pike::Elements::FriendshipList::FriendshipListAddFriendshipItem.new)
          Pike::Session.identity.user.friendships_as_source.all.each do |friendship|
            self.items.push(Pike::Elements::FriendshipList::FriendshipListFriendshipItem.new(friendship))
          end

        end
        super(format)
      end

    end

  end

end
