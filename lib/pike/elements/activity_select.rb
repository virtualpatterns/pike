module Pike

  module Elements
    require 'pike'
    require 'pike/elements/lists/select'

    class ActivitySelect < Pike::Elements::Lists::Select

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.activities.all
      end

    end

  end

end
