require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class IntroductionEditPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Introduction', 'An introduction will be sent to the user specified.  They will not appear as your friend until the introduction is accepted.')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @introduction.save!
                  self.hide(_event)
                end
              end
            end
          end

          @user_target_input = Pike::Elements::Inputs::UserInput.new
          @user_target_input.attributes.merge!('placeholder' => 'tap to enter a user\'s email')
          @user_target_input.changed do |element, event|
            @introduction.user_target = @user_target_input.user
          end

          @message_input = Pike::Elements::Inputs::MultilineInput.new
          @message_input.attributes.merge!('placeholder' => 'tap to enter a message')
          @message_input.changed do |element, event|
            @introduction.message = @message_input.value
          end

        end

      end

    end

  end

end
