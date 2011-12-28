require 'rubygems'
require 'bundler/setup'

require 'socket'

require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'

      class AboutPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(now = Time.now)
          super()

          @now = now

          @back_button = RubyApp::Elements::Navigation::BackButton.new

        end

      end

    end

  end

end
