require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'elements/pages/blank_page'
      require 'session'

      class SelectPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

        end

      end

    end

  end

end
