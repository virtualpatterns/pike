require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Documents

      module Authentication
        require 'pike/models'

        class FacebookAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::Facebook::EmailAuthenticationDocument

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
          end

          def create_identity_from_email(email)
            return Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_FACEBOOK,
                                                  :user   => Pike::User.get_user_by_url(email))
          end

        end

      end

    end

  end

end
