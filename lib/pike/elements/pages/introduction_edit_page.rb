require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/exception_dialog'
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
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              @introduction.save!
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @introduction_to_input = Pike::Elements::UserInput.new
          @introduction_to_input.changed do |element, event|
            @introduction.introduction_to = @introduction_to_input.user
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
