module Pike

  module Elements
    require 'elements/lists/select'
    require 'session'

    class ProjectSelect < Pike::Elements::Lists::Select

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = Pike::Session.identity.user.projects.all.collect
      end

    end

  end

end
