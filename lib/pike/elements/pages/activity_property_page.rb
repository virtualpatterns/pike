module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/property_page'

      class ActivityPropertyPage < Pike::Elements::Pages::PropertyPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(object, property = nil)
          super(:activity_properties, object, property)
        end

      end

    end

  end

end
