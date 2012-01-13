require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/acknowledgement_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/dialogs/message_dialog'
require 'ruby_app/elements/inputs/multiline_input'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/elements/user_input'
      require 'pike/session'

      class IntroductionEditPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::AcknowledgementDialog.new('Introduction', 'An introduction will be sent to the user specified.  They will not appear as your friend until the introduction is accepted.')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @introduction.save!
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

          @user_target_input = Pike::Elements::UserInput.new
          @user_target_input.changed do |element, event|
            @introduction.user_target = @user_target_input.user
          end

          @message_input = RubyApp::Elements::Inputs::MultilineInput.new
          @message_input.changed do |element, event|
            @introduction.message = @message_input.value
          end

        end

      end

    end

  end

end
