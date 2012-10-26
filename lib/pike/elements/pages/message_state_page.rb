require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/page'

      class MessageStatePage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(message_state)
          super()

          @message_state = message_state

          @back_button = Pike::Elements::Navigation::BackButton.new

          self.shown do |element, event|
            message_state.read!
          end

        end

      end

    end

  end

end
