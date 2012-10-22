require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class FriendshipList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class FriendshipListIntroductionDivider < RubyApp::Elements::Mobile::Navigation::NavigationList::ListDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super('Introductions')
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
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.attributes.merge!('class'              => 'friendship-list',
                               'data-divider-theme' => 'd',
                               'data-theme'         => 'd')
      end

      def render(format)
        if format == :html

          self.items.clear

          if Pike::Session.identity.user.introductions_as_target.exists?
            self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionDivider.new)
            Pike::Session.identity.user.introductions_as_target.all.each do |introduction|
              self.items.push(Pike::Elements::FriendshipList::FriendshipListIntroductionItem.new(introduction))
            end
            self.items.push(Pike::Elements::FriendshipList::FriendshipListFriendshipDivider.new)
          end

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
