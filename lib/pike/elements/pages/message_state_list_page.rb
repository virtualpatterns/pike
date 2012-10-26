require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class MessageStateListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @clear_button = RubyApp::Elements::Mobile::Button.new
          @clear_button.clicked do |element, event|
            Pike::Session.identity.user.messages.all.each do |message|
              Pike::Session.identity.user.read!(message)
            end
            Pike::Session.document.page.hide(event)
          end

          @message_state_list = Pike::Elements::MessageStateList.new

        end

      end

    end

  end

end
