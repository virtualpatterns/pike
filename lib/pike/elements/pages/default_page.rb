require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/page'
require 'ruby_app/version'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/authentication/open_id/google_authentication_page'
      require 'pike/elements/pages/work_list_page'
      require 'pike/session'
      require 'pike/version'

      class DefaultPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @logon_button = RubyApp::Elements::Button.new
          @logon_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::Authentication::OpenID::GoogleAuthenticationPage.new)
            event.refresh
          end

          @logoff_button = RubyApp::Elements::Button.new
          @logoff_button.clicked do |element, event|
            Pike::Session.identity = nil
            event.refresh
          end

          @continue_button = RubyApp::Elements::Button.new
          @continue_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show(event) do
              Pike::Session.identity.user.work.where_started.where_not_date(Date.today).each { |work| work.finish! }
              Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new)
              event.refresh
            end
          end

          @settings_button = RubyApp::Elements::Button.new
          @settings_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::SettingsPage.new)
            event.refresh
          end

        end

      end

    end

  end

end
