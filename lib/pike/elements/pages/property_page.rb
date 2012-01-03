require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/input'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/session'

      class PropertyPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(object, property = nil)
          super()

          @user = Pike::Session.identity.user
          @object = object
          @property = property
          @value = @property ? @object.read_attribute(@property) : nil

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              @user.push(:project_properties, @property) unless @user.project_properties.include?(@property)
              @object.write_attribute(@property, @value) if @property
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @property_input = RubyApp::Elements::Input.new
          @property_input.value = @property
          @property_input.changed do |element, event|
            @property = @property_input.value
          end

          @value_input = RubyApp::Elements::Input.new
          @value_input.value = @value
          @value_input.changed do |element, event|
            @value = @value_input.value
          end

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to remove this property?')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @user.pull(:project_properties, @property)
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
