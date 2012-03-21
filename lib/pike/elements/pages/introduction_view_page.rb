require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements/pages/properties_page'

      class IntroductionViewPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @accept_button = RubyApp::Elements::Button.new
          @accept_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::AcknowledgementDialog.new('Introduction', 'Any shared projects and activities will be added momentarily.')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @introduction.accept!
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

          @reject_button = RubyApp::Elements::Button.new
          @reject_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to ignore this introduction?')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @introduction.reject!
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
