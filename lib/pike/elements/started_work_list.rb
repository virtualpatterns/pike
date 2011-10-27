require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

require 'ruby_app/elements/list'

module Pike

  module Elements
    require 'pike/models'
    require 'pike/session'

    class StartedWorkList < RubyApp::Elements::List

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

      def render(format)
        self.items = Pike::Session.identity.user.work.where_started.where_not_date(Date.today).all if format == :html
        @flag = nil
        super(format)
      end

    end

  end

end
