require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/inputs/email_input'

module Pike

  module Elements
    require 'pike/models'

    class UserInput < RubyApp::Elements::Inputs::EmailInput

      template_path(:all, File.dirname(__FILE__))

      attr_accessor :user

      def initialize
        super
      end

      def user=(value)
        @user = value
        @value = user.url
      end

      protected

        def on_changed(event)
          RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
            @user = Pike::User.get_user_by_url(event.value, false)
            @value = @user ? user.url : nil
            raise "The user #{event.value} does not exist." unless @user
            event.update_value("##{self.element_id}", @value)
            changed(event)
          end
        end

    end

  end

end
