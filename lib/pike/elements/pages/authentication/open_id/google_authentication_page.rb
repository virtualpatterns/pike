require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'pike'
          require 'pike/models'

          class GoogleAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::GoogleAuthenticationPage

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
