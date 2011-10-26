require 'rubygems'
require 'bundler/setup'

require 'ruby_app/session'

module Pike
  require 'elements/pages/default_page'
  require 'models'

  class Session < RubyApp::Session

    class Identity < RubyApp::Session::Identity

      def initialize(url, data = {})
        super(url, data.merge(:user => Pike::User.get_user(url)))
      end

    end

    def initialize(page = nil)
      super(page || Pike::Elements::Pages::DefaultPage.new)
    end

  end

end
