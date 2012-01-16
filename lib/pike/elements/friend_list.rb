require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/list'

module Pike

  module Elements
    require 'pike/session'

    class FriendList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.friendships_as_source.all
      end

    end

  end

end
