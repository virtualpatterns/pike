require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class FriendPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(friendship)
          super()

          @friendship = friendship

          @back_button = Pike::Elements::Navigation::BackButton.new

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to remove this friend?  Any shared projects and activities will be deleted momentarily.')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_dialog(_event) do
                  Pike::Friendship.where_friendship(@friendship.user_source, @friendship.user_target).each do |_friendship|
                    _friendship.destroy
                  end
                  Pike::Friendship.where_friendship(@friendship.user_target, @friendship.user_source).each do |_friendship|
                    _friendship.destroy
                  end
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
