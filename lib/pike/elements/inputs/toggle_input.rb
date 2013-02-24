require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Inputs

      class ToggleInput < RubyApp::Elements::Mobile::Inputs::ToggleInput

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          self.attributes.merge!('data-mini'        => 'true',
                                 'data-theme'       => 'c',
                                 'data-track-theme' => 'c')
        end

      end

    end

  end

end
