require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Navigation

      class BackButton < RubyApp::Elements::Mobile::Navigation::BackButton

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          #self.attributes.merge!('data-icon'    => 'arrow-l',
          #                       'data-iconpos' => 'left')
        end

      end

    end

  end

end
