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

        def initialize(object, type, property = nil)
          super()

          @user = Pike::Session.identity.user
          @object = object
          @type = type
          @property = property
          @value = @property ? @object.values.where_property(@property).first : nil

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              # TODO ... index user.properties.where_type, user.properties.where_name, and user.properties.where_not_copy
              @property = @property || @user.properties.where_type(@type).where_name(@name_input.value).where_not_copy.first || @user.properties.create!(:type => @type,
                                                                                                                                          :name => @name_input.value) unless @property
              # TODO ... index object.values.where_property
              @value = @value || @object.values.where_property(@property).first || @object.values.create!(:property => @property) unless @value
              @value.value = @value_input.value
              @value.save!
              self.hide(event)
            end
          end

          @name_input = Pike::Elements::Input.new
          @name_input.attributes.merge!('autofocus'   => @property ? false : true,
                                            'placeholder' => 'tap to enter a name')
          @name_input.value = @property ? @property.name : nil

          @value_input = Pike::Elements::Input.new
          @value_input.attributes.merge!('autofocus'  => @property ? true : false,
                                         :placeholder => 'tap to enter a value')
          @value_input.value = @value ? @value.value : nil

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to remove this property?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @property.destroy
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
