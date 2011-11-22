module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'

      class PropertiesPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
