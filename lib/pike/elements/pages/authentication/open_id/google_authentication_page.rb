module Pike

  module Elements

    module Pages

      module Authentication

        module OpenID
          require 'ruby_app/elements/pages/authentication/open_id/google_authentication_page'

          class GoogleAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenID::GoogleAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super()
            end

            def create_identity_from_url(url, data = {})
              Pike::Session::Identity.new(data.email, data)
            end

          end

        end

      end

    end

  end

end
