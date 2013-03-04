require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Inputs
      require 'pike/models'

      class UserInput < RubyApp::Elements::Mobile::Inputs::EmailInput

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :user

        def initialize
          super
        end

        def user=(value)
          @user = value
          @value = user.uri
        end

        protected

          def on_changed(event)
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @user = Pike::User.get_user_by_uri(event.value, false)
              @value = @user ? user.uri : nil
              raise 'The user specified does not exist.' unless @user
              event.update_value("##{self.element_id}", @value, false)
            end
            changed(event)
          end

      end

    end

  end

end
