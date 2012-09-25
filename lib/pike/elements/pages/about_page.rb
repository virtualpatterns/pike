require 'rubygems'
require 'bundler/setup'

require 'socket'
require 'uri'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike/elements'

      class AboutPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(now = Time.now)
          super()

          @now = now

          @back_button = Pike::Elements::Navigation::BackButton.new

          @information_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @information_link.clicked do |element, event|
            RubyApp::Elements::Mobile::Pages::InformationPage.new(event.now).show(event)
          end

        end

      end

    end

  end

end
