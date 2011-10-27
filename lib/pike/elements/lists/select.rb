require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/lists/select'

module Pike

  module Elements

    module Lists

      class Select < RubyApp::Elements::Lists::Select

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
