require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/message_state_page'

    class MessageStateList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class MessageStateListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :message_state :item

        def initialize(message)
          super(message)
          self.attributes.merge!('class' => 'message-state-list-item')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        
        self.attributes.merge!('class'      => 'message-state-list',
                               'data-theme' => 'd')

        self.item_clicked do |element, event|
          page = Pike::Elements::Pages::MessageStatePage.new(event.item.message_state)
          page.removed do |element, _event|
            _event.update_element(self)
            Pike::Session.document.page.hide(_event) unless Pike::Session.identity.user.message_states.where_new.exists?
          end
          page.show(event)
        end

      end

      def render(format)
        if format == :html
          self.items.clear
          Pike::Session.identity.user.message_states.where_new.each do |message_state|
            self.items.push(Pike::Elements::MessageStateList::MessageStateListItem.new(message_state))
          end
        end
        super(format)
      end

    end

  end

end
