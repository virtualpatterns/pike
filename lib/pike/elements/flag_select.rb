module Pike

  module Elements
    require 'pike'
    require 'pike/elements/lists/select'
    require 'pike/models'

    class FlagSelect < Pike::Elements::Lists::Select

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        self.items = [ Pike::Task::FLAG_LIKED,
                       Pike::Task::FLAG_NORMAL,
                       Pike::Task::FLAG_COMPLETED ]
      end

    end

  end

end
