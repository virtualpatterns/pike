require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/mail'

module Pike

  module Elements

    module Mail

      class BlankMail < RubyApp::Elements::Mail

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
