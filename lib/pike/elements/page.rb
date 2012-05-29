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
      end

    end

  end

end
