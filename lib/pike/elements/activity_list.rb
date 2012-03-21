require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/activity_page'

    class ActivityList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.activities.all
      end

    end

  end

end
