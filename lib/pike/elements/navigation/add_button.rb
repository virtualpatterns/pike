module Pike

  module Elements

    module Navigation
      require 'pike/elements/navigation/navigation_button'

      class AddButton < Pike::Elements::Navigation::NavigationButton

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          self.attributes.merge!('data-icon'    => nil,
                                 'data-iconpos' => nil)
        end

      end

    end

  end

end
