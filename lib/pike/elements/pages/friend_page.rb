require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/acknowledgement_dialog'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/properties_page'
      require 'pike/session'

      class FriendPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(friendship)
          super()

          @friendship = friendship

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to remove this friend?')) do |_event, response|
              if response
                Pike::Session.show_dialog(_event, RubyApp::Elements::Dialogs::AcknowledgementDialog.new('Friend', 'This friend will be removed.  Any shared data will be removed momentarily.')) do |__event, response|
                  if response
                    RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(__event) do
                      Pike::Friendship.where_friendship(@friendship.user_source, @friendship.user_target).each do |_friendship|
                        _friendship.destroy
                      end
                      Pike::Friendship.where_friendship(@friendship.user_target, @friendship.user_source).each do |_friendship|
                        _friendship.destroy
                      end
                      Pike::Session.pages.pop
                      __event.refresh
                    end
                  end
                end
              end
            end
          end

        end

      end

    end

  end

end
