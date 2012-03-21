require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class IntroductionList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.introductions_as_target.all
      end

    end

  end

end
