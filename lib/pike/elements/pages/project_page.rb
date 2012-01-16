require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/input'
require 'ruby_app/elements/inputs/toggle_input'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/elements/properties'
      require 'pike/session'

      class ProjectPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(project)
          super()

          @project = project

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              @project.save!
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @name_input = RubyApp::Elements::Input.new
          @name_input.value = @project.name
          @name_input.changed do |element, event|
            @project.name = @name_input.value
          end

          @is_shared_input = RubyApp::Elements::Inputs::ToggleInput.new
          @is_shared_input.value = @project.is_shared
          @is_shared_input.changed do |element, event|
            @project.is_shared = @is_shared_input.value
          end

          @properties = Pike::Elements::Properties.new(:project_properties, @project)

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this project?')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @project.destroy
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

        end

      end

    end

  end

end
