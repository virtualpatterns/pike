require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/page'

      class MessagePage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(message)
          super()

          @message = message

          @back_button = Pike::Elements::Navigation::BackButton.new

          self.shown do |element, event|
            Pike::Session.identity.user.read!(message)
            Pike::Session.identity.user.reload
          end

        end

      end

    end

  end

end
