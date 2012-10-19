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
              super(ENV['GITHUB_ACCESS_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.access_key,
                    ENV['GITHUB_SECRET_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.secret_key,
                    ['repos'])
            end

            def process_token(token)
              super(token)
              Pike::Session.identity.token = token
            end

            def create_identity_from_email(email)
              return Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_GITHUB,
                                                    :user   => Pike::User.get_user_by_url(email))
            end

          end

        end

      end

    end

  end

end
