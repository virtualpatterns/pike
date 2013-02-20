require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    class Page < RubyApp::Elements::Mobile::Page

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.attributes.merge!('data-theme' => 'b')

        self.loaded do |element, event|
          event.execute("_gaq.push(['_trackEvent', 'Page', 'Loaded', '#{self.class}']);")
        end
        self.shown do |element, event|
          event.execute("_gaq.push(['_trackEvent', 'Page', 'Shown', '#{self.class}']);")
        end

      end

    end

  end

end
