require 'rubygems'
require 'bundler/setup'

require 'chronic'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/markdown'
require 'ruby_app/elements/page'
require 'ruby_app/request'
require 'ruby_app/version'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/authentication/open_id/google_authentication_page'
      require 'pike/elements/pages/work_list_page'
      require 'pike/models'
      require 'pike/session'
      require 'pike/version'

      class DefaultPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          self.loaded do |element, event|
            unless Pike::Session.identity
              if RubyApp::Request.cookies['_identity']
                identity = Pike::Identity.get_identity_by_value(RubyApp::Request.cookies['_identity'])
                if identity
                  Pike::Session.identity = Pike::Session::Identity.new(identity.user)
                  identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
                  Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new(event.today, event.today))
                  event.refresh
                end
              end
            end
          end

          @logon_button = RubyApp::Elements::Button.new
          @logon_button.clicked do |element, event|
            unless Pike::User.exists_guest_user?
              Pike::Session.pages.push(Pike::Elements::Pages::Authentication::OpenID::GoogleAuthenticationPage.new)
            else
              Pike::Session.identity = Pike::Session::Identity.new(Pike::User.create_guest_user!)
            end
            event.refresh
          end

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'logon_demo_user'
                user = Pike::User.get_user_by_url('demo@pike.virtualpatterns.com')
                Pike::Session.identity = Pike::Session::Identity.new(user)
                user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
                Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new(event.today, event.today))
                event.refresh
            end
          end

          @logoff_button = RubyApp::Elements::Button.new
          @logoff_button.clicked do |element, event|
            Pike::Session.identity = nil
            event.refresh
          end

          @continue_button = RubyApp::Elements::Button.new
          @continue_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              identity = Pike::Session.identity.user.identities.create!
              event.set_cookie('_identity', identity.value, Chronic.parse('next month'))
              identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
              Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new(event.today, event.today))
              event.refresh
            end
          end

        end

      end

    end

  end

end
