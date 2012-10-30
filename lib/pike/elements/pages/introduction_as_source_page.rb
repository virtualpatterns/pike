require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class IntroductionAsSourcePage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @back_button = Pike::Elements::Navigation::BackButton.new

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this introduction?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @introduction.destroy
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
