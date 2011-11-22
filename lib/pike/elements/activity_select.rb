module Pike

  module Elements
    require 'pike/elements/lists/select'
    require 'pike/session'

    class ActivitySelect < Pike::Elements::Lists::Select

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.activities.all
      end

    end

  end

end
