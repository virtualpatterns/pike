require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Inputs

      class DurationInput < RubyApp::Elements::Mobile::Inputs::DurationInput

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
