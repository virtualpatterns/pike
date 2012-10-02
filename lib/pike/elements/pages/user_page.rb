require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class UserPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @user = nil
          
          @back_button = Pike::Elements::Navigation::BackButton.new

          @save_button = Pike::Elements::Navigation::SaveButton.new
          @save_button.clicked do |element, event|
            unless @user
              RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('User', 'A valid user email is required.'))
            else
              RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
                @user.save!
                event.update_text("code[data-field='updated_at']", RubyApp::Language.locale.strftime(@user.updated_at, Pike::Application.configuration.format.date.long))
              end
            end
          end

          @user_input = Pike::Elements::Inputs::UserInput.new
          @user_input.attributes.merge!('autofocus'   => true,
                                        'placeholder' => 'tap to enter a user\'s email')
          @user_input.changed do |element, event|
            @user = @user_input.user
            if @user
              @is_administrator_input.attributes.merge!('disabled' => false)
              @is_administrator_input.value = @user.is_administrator
              event.execute("$('##{@is_administrator_input.element_id}').slider('enable');")
              event.update_value("##{@is_administrator_input.element_id}", @user.is_administrator.to_s)
              event.update_text("code[data-field='created_at']", RubyApp::Language.locale.strftime(@user.created_at, Pike::Application.configuration.format.date.long))
              event.update_text("code[data-field='updated_at']", RubyApp::Language.locale.strftime(@user.updated_at, Pike::Application.configuration.format.date.long))
            else
              @is_administrator_input.attributes.merge!('disabled' => true)
              @is_administrator_input.value = false
              event.execute("$('##{@is_administrator_input.element_id}').slider('disable');")
              event.update_value("##{@is_administrator_input.element_id}", 'false')
              event.update_text("code[data-field='created_at']", '')
              event.update_text("code[data-field='updated_at']", '')
            end
          end

          @is_administrator_input = Pike::Elements::Inputs::ToggleInput.new
          @is_administrator_input.attributes.merge!('disabled' => true)
          @is_administrator_input.changed do |element, event|
            @user.is_administrator = @is_administrator_input.value if @user
          end

        end

      end

    end

  end

end
