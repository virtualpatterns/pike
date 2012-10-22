require 'rubygems'
require 'bundler/setup'

require 'openid/extensions/ax'

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

            def process_ax_request(ax_request)
              super(ax_request)
              ax_request.add(::OpenID::AX::AttrInfo.new(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.first_name, 'FirstName', true))
              ax_request.add(::OpenID::AX::AttrInfo.new(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.last_name, 'LastName', true))
            end

            def create_identity_from_ax_response(ax_response)
              user = Pike::User.get_user_by_url(ax_response.data[RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.email].first)
              user.name = "#{ax_response.data[RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.first_name].first} #{ax_response.data[RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.last_name].first}"
              user.save!
              return Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_GOOGLE,
                                                    :user   => user)
            end

          end

        end

      end

    end

  end

end
