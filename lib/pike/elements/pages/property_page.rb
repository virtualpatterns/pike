require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class PropertyPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(properties, object, property = nil)
          super()

          @user = Pike::Session.identity.user
          @properties = properties
          @object = object
          @property = property
          @value = @property ? @object.read_attribute(@property) : nil

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            unless @property
              RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Property', 'A name is required.'))
            else
              RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
                @user.push(@properties, @property) unless @user.send(@properties).include?(@property)
                @object.write_attribute(@property, @value)
                self.hide(event)
              end
            end
          end

          @property_input = Pike::Elements::Input.new
          @property_input.attributes.merge!('autofocus'   => @property ? false : true,
                                            'placeholder' => 'tap to enter a name')
          @property_input.value = @property
          @property_input.changed do |element, event|
            @property = @property_input.value
          end

          @value_input = Pike::Elements::Input.new
          @value_input.attributes.merge!('autofocus'  => @property ? true : false,
                                         :placeholder => 'tap to enter a value')
          @value_input.value = @value
          @value_input.changed do |element, event|
            @value = @value_input.value
          end

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to remove this property?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @user.pull(@properties, @property)
                  self.hide(_event)
                end
              end
            end
          end

        end

      end

    end

  end

end
