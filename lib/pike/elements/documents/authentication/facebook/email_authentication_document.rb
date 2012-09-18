require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Documents

      module Authentication

        module Facebook
          require 'pike/models'

          class EmailAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::Facebook::EmailAuthenticationDocument

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

            def create_identity_from_me(me)
              Pike::System::Identity.create!(:user => Pike::User.get_user_by_url(me['email']))
            end

          end

        end

      end

    end

  end

end
