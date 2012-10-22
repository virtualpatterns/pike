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

            def create_identity_from_token(token)
              user = JSON.parse(token.get('/user').body)
              RubyApp::Log.debug("GITHUB    user=#{user.inspect}")
              _user = Pike::User.get_user_by_url(user['email'])
              _user.name = user['name']
              _user.save!
              return Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_GITHUB,
                                                    :user   => _user)
            end

          end

        end

      end

    end

  end

end
