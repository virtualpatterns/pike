require 'rubygems'
require 'bundler/setup'

require 'chronic'

require 'ruby_app'
require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/documents/authentication/facebook_authentication_document'
      require 'pike/elements/documents/authentication/open_id/google_authentication_document'
      require 'pike/elements/documents/authentication/o_auth/git_hub_authentication_document'
      require 'pike/elements/pages/work_list_page'
      require 'pike/models'

      class DefaultPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          self.attributes.merge!('data-theme' => 'a')

          self.loaded do |element, event|
            unless Pike::Session.identity
              if RubyApp::Request.cookies['identity']
                identity = Pike::System::Identity.get_identity_by_value(RubyApp::Request.cookies['identity'])
                if identity
                  Pike::Session.identity = identity
                  RubyApp::Log.info("SESSION   Pike::Session.identity.url=#{Pike::Session.identity.url.inspect}")
                  Pike::Session.identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
                  Pike::Elements::Pages::WorkListPage.new(event.today, event.today).show(event)
                end
              end
            else
              RubyApp::Response.set_cookie('identity', {:value    => Pike::Session.identity.value,
                                                        :path     => '/',
                                                        :expires  => Pike::Session.identity.expires})
              Pike::Session.identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
              Pike::Elements::Pages::WorkListPage.new(event.today, event.today).show(event)
            end
          end

          @scripts_button = RubyApp::Elements::Mobile::Button.new
          @scripts_button.attributes.merge!('class' => 'ui-btn-right')
          @scripts_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Pages::ScriptsPage.new.show(event)
          end

          @logon_github_button = RubyApp::Elements::Mobile::Button.new
          @logon_github_button.attributes.merge!('class'        => 'logon',
                                                 'data-icon'    => 'arrow-r',
                                                 'data-iconpos' => 'right')
          @logon_github_button.clicked do |element, event|
            Pike::Elements::Documents::Authentication::OAuth::GitHubAuthenticationDocument.new.show(event)
          end

          @logon_google_button = RubyApp::Elements::Mobile::Button.new
          @logon_google_button.attributes.merge!('class'        => 'logon',
                                                 'data-icon'    => 'arrow-r',
                                                 'data-iconpos' => 'right')
          @logon_google_button.clicked do |element, event|
            Pike::Elements::Documents::Authentication::OpenId::GoogleAuthenticationDocument.new.show(event)
          end

          @logon_facebook_button = RubyApp::Elements::Mobile::Button.new
          @logon_facebook_button.attributes.merge!('class'        => 'logon',
                                                   'data-icon'    => 'arrow-r',
                                                   'data-iconpos' => 'right')
          @logon_facebook_button.clicked do |element, event|
            Pike::Elements::Documents::Authentication::FacebookAuthenticationDocument.new.show(event)
          end

          @first_button = RubyApp::Elements::Mobile::Button.new
          @first_button.attributes.merge!('data-mini' => 'true')
          @first_button.clicked do |element, event|
            user = Pike::User.get_user_by_url('first@pike.virtualpatterns.com')
            user.name = "First User"
            user.save!
            Pike::Session.identity = Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_UNKNOWN,
                                                                    :user   => user)
            Pike::Session.identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
            Pike::Elements::Pages::WorkListPage.new(event.today, event.today).show(event)
          end

          @second_button = RubyApp::Elements::Mobile::Button.new
          @second_button.attributes.merge!('data-mini'  => 'true')
          @second_button.clicked do |element, event|
            user = Pike::User.get_user_by_url('second@pike.virtualpatterns.com')
            user.name = "Second User"
            user.save!
            Pike::Session.identity = Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_UNKNOWN,
                                                                    :user   => user)
            Pike::Session.identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
            Pike::Elements::Pages::WorkListPage.new(event.today, event.today).show(event)
          end

          @random_button = RubyApp::Elements::Mobile::Button.new
          @random_button.attributes.merge!('data-mini'  => 'true')
          @random_button.clicked do |element, event|
            user = Pike::User.get_random_user
            user.name = "Random User"
            user.save!
            Pike::Session.identity = Pike::System::Identity.create!(:source => Pike::System::Identity::SOURCE_GITHUB,
                                                                    :user   => user)
            Pike::Session.identity.user.work.where_started.where_not_date(event.today).each { |work| work.finish! }
            Pike::Elements::Pages::WorkListPage.new(event.today, event.today).show(event)
          end

        end

      end   

    end

  end

end
