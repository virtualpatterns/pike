require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Navigation

      class NavigationButton < RubyApp::Elements::Mobile::Navigation::NavigationButton

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          self.attributes.merge!('data-icon'    => 'arrow-r',
                                 'data-iconpos' => 'right')
        end

      end

    end

  end

end
