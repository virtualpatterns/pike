require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/pages/authentication/open_id/google_authentication_page'

module Pike

  module Elements

    module Pages

      module Authentication

        module OpenID
          require 'pike/models'
          require 'pike/session'

          class GoogleAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenID::GoogleAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super()
            end

            def create_identity_from_email(email)
              Pike::Session::Identity.new(Pike::User.get_user_by_url(email))
            end

          end

        end

      end

    end

  end

end
