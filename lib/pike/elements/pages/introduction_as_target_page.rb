require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class IntroductionAsTargetPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @back_button = Pike::Elements::Navigation::BackButton.new

          @accept_button = RubyApp::Elements::Mobile::Button.new
          @accept_button.attributes.merge!('data-theme' => 'c')
          @accept_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @introduction.accept!
              self.hide(event)
            end
          end

          @reject_button = RubyApp::Elements::Mobile::Button.new
          @reject_button.attributes.merge!('data-theme' => 'f')
          @reject_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to ignore this introduction?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @introduction.reject!
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
