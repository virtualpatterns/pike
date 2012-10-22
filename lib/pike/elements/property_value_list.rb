require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/property_value_page'

    class PropertyValueList < RubyApp::Elements::Mobile::Navigation::NavigationList

      class PropertyValueListAddItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class PropertyValueListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        attr_reader :property
        attr_reader :value

        def initialize(property, value = nil)
          super(nil)

          self.attributes.merge!('class' => 'property-value-list-item')

          @property = property
          @value = value

        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize(object, type)
        super()

        self.attributes.merge!('class'      => 'property-value-list',
                               'data-inset' => 'true',
                               'data-theme' => 'd')

        @object = object
        @type = type

        self.item_clicked do |element, event|
          if event.item.is_a?(Pike::Elements::PropertyValueList::PropertyValueListAddItem)
            page = Pike::Elements::Pages::PropertyValuePage.new(@object, @type)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          else
            page = Pike::Elements::Pages::PropertyValuePage.new(@object, @type, event.item.property, event.item.value)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          end
        end
        
      end

      def render(format)
        if format == :html
          self.items.clear
          self.items.push(Pike::Elements::PropertyValueList::PropertyValueListAddItem.new) unless @object.new? || @object.copy?
          Pike::Session.identity.user.properties.where_type(@type).each do |property|
            item = Pike::Elements::PropertyValueList::PropertyValueListItem.new(property, @object.values.where_property(property).first)
            item.attributes.merge!('disabled' => true) if @object.new? || @object.copy?
            self.items.push(item)
          end
        end
        super(format)
      end

    end

  end

end
