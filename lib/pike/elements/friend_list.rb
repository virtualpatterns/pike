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
      end

      def render(format)
        self.items = Pike::Session.identity.user.friends.all if format == :html
        super(format)
      end

    end

  end

end
