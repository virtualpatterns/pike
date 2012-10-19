module Pike

  module Elements

    module Documents

      module Authentication

        module OAuth
          require 'pike/elements/documents/authentication/o_auth/git_hub_authentication_document'
          require 'pike/models'

          class GitHubTokenDocument < Pike::Elements::Documents::Authentication::OAuth::GitHubAuthenticationDocument

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

            def process_token(token)
              Pike::Session.identity.token = token
            end

          end

        end

      end

    end

  end

end
