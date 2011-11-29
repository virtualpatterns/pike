require 'rubygems'
require 'bundler/setup'

require 'ruby_app/session'

module Pike
  require 'pike/elements/pages/default_page'
  require 'pike/models'

  class Session < RubyApp::Session

    class Identity < RubyApp::Session::Identity

      attr_reader :user

      def initialize(user)
        @user = user
        super(user.url)
      end

    end

    def initialize(page = nil)
      super(page || Pike::Elements::Pages::DefaultPage.new)
    end

  end

end
