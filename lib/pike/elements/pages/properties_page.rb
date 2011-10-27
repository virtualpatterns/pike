require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'
      require 'pike/session'

      class PropertiesPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(object)
          super()

          @object = object

          @cancel_button = RubyApp::Elements::Button.new
          @cancel_button.clicked do |element, event|
            Pike::Session.pages.pop
            event.refresh
          end

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            begin
              @object.save!
              Pike::Session.pages.pop
              event.refresh
            rescue Exception => exception
              Pike::Session.show(event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
            end
          end

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure?')) do |_event, response|
              if response
                begin
                  @object.destroy!
                  Pike::Session.pages.pop
                  _event.refresh
                rescue Exception => exception
                  Pike::Session.show(_event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
                end
              end
            end
          end

        end

      end

    end

  end

end
