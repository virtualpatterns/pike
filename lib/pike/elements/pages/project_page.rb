require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/input'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/session'

      class ProjectPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(project)
          super(project)

          @project = project

          @name_input = RubyApp::Elements::Input.new
          @name_input.value = @project.name
          @name_input.changed do |element, event|
            @project.name = @name_input.value
          end

        end

      end

    end

  end

end
