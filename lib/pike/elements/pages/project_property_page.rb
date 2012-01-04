module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/property_page'

      class ProjectPropertyPage < Pike::Elements::Pages::PropertyPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(object, property = nil)
          super(:project_properties, object, property)
        end

      end

    end

  end

end
