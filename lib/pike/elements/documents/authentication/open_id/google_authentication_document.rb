require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Documents

      module Authentication

        module OpenId
          require 'pike/models'

          class GoogleAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::GoogleAuthenticationDocument

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

            def create_identity_from_email(email)
              Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_GOOGLE,
                                             :user   => Pike::User.get_user_by_url(email))
            end

          end

        end

      end

    end

  end

end
