require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  class Session < RubyApp::Session

    class Identity < RubyApp::Session::Identity

      attr_reader :user

      def initialize(user)
        @user = user
        super(user.url)
      end

    end

    def initialize
      require 'pike/elements/pages'
      super(Pike::Elements::Pages::DefaultPage.new)
    end

  end

end
