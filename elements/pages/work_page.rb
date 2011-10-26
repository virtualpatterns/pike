require 'rubygems'
require 'bundler/setup'

require 'ruby_app/language'

module Pike

  module Elements

    module Pages
      require 'application'
      require 'elements/pages/properties_page'
      require 'session'

      class WorkPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(work)
          super(work)

          @work = work

          @duration_input = RubyApp::Elements::Inputs::DurationInput.new
          @duration_input.duration = @work.duration
          @duration_input.changed do |element, event|
            @work.duration = @duration_input.duration
          end

        end

      end

    end

  end

end
