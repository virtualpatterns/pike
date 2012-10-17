require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Documents

      module Authentication

        module OAuth
          require 'pike/models'

          class GitHubAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

            def create_identity_from_email(email)
              return Pike::System::Identity.create!(:user => Pike::User.get_user_by_url(email))
            end

          end

        end

      end

    end

  end

end
