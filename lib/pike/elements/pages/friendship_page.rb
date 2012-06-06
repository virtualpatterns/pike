require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class FriendshipPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(friendship)
          super()

          @friendship = friendship

          @back_button = Pike::Elements::Navigation::BackButton.new

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this friend?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  Pike::Friendship.where_friendship(@friendship.user_source, @friendship.user_target).each do |_friendship|
                    _friendship.destroy
                  end
                  Pike::Friendship.where_friendship(@friendship.user_target, @friendship.user_source).each do |_friendship|
                    _friendship.destroy
                  end
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
