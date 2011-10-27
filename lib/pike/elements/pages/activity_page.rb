require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/input'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/session'

      class ActivityPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(activity)
          super(activity)

          @activity = activity

          @name_input = RubyApp::Elements::Input.new
          @name_input.value = @activity.name
          @name_input.changed do |element, event|
            @activity.name = @name_input.value
          end

        end

      end

    end

  end

end
