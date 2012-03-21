require 'rubygems'
require 'bundler/setup'

require 'socket'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'

      class AboutPage < Pike::Elements::Pages::PropertiesPage

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
