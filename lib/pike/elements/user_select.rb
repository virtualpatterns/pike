require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class UserSelect < RubyApp::Elements::Mobile::List

      class UserSelectItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        alias :user :item

        def initialize(user)
          super(user)
          self.attributes.merge!('class' => 'user-select-item')
        end

      end

      class UserSelectedItem < Pike::Elements::UserSelect::UserSelectItem

        template_path(:all, File.dirname(__FILE__))

        alias :user :item

        def initialize(user)
          super(user)
          self.attributes.merge!('data-icon' => 'check')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize(introduction)
        super()

        @introduction = introduction

        self.search_value = @introduction.user_target ? @introduction.user_target.name : nil

        self.attributes.merge!('class'                    => 'user-select',
                               'data-filter'              => 'true',
                               'data-filter-placeholder'  => 'tap to search by name',
                               'data-theme'               => 'd')

        self.searched do |element, event|
          event.update_element(self)
        end
        self.item_clicked do |element, event|
          @introduction.user_target = event.item.user
          Pike::Session.document.page.hide(event)
        end
        
      end

      def render(format)
        if format == :html
          self.items.clear
          if self.search_value
            Pike::User.where_search(Pike::Session.identity.user, self.search_value).each do |user|
              self.items.push(user == @introduction.user_target ?  Pike::Elements::UserSelect::UserSelectedItem.new(user) : Pike::Elements::UserSelect::UserSelectItem.new(user))
            end
          end
        end
        super(format)
      end

    end

  end

end
