require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class FriendList < RubyApp::Elements::Mobile::Navigation::NavigationList

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.friendships_as_source.all
      end

    end

  end

end
