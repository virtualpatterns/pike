require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    class Input < RubyApp::Elements::Mobile::Input

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

    end

  end

end
