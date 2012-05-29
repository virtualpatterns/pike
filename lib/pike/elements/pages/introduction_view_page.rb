require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class IntroductionViewPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @back_button = Pike::Elements::Navigation::BackButton.new

          @accept_button = RubyApp::Elements::Mobile::Button.new
          @accept_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Introduction', 'Any shared projects and activities will be added momentarily.')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @introduction.accept!
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

          @reject_button = RubyApp::Elements::Mobile::Button.new
          @reject_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to ignore this introduction?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_dialog(_event) do
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
