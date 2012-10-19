require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/message_page'

    class MessageList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class MessageListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        alias :message :item

        def initialize(message)
          super(message)
          self.attributes.merge!('class' => 'message-list-item')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        
        self.attributes.merge!('class'      => 'message-list',
                               'data-theme' => 'd')

        self.item_clicked do |element, event|
          page = Pike::Elements::Pages::MessagePage.new(event.item.message)
          page.removed do |element, _event|
            _event.update_element(self)
            Pike::Session.document.page.hide(_event) unless Pike::Session.identity.user.messages.exists?
          end
          page.show(event)
        end

      end

      def render(format)
        if format == :html
          self.items.clear
          Pike::Session.identity.user.messages.all.each do |message|
            self.items.push(Pike::Elements::MessageList::MessageListItem.new(message))
          end
        end
        super(format)
      end

    end

  end

end
