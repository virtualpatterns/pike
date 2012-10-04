require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/navigation/add_button'
    require 'pike/elements/pages/property_page'

    class PropertyValueList < RubyApp::Element

      template_path(:all, File.dirname(__FILE__))

      def initialize(object, type)
        super()

        self.attributes.merge!('data-inset' => 'true',
                               'data-role'  => 'listview',
                               'data-theme' => 'd')

        @user = Pike::Session.identity.user
        @object = object
        @type = type

        @add_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
        @add_link.clicked do |element, event|
          page = Pike::Elements::Pages::PropertyPage.new(@object, @type)
          page.removed do |element, _event|
            _event.update_element(self)
          end
          page.show(event)
        end

      end

      def render(format)
        if format == :html
          @links = {}
          # TODO ... index user.properties.where_type
          @user.properties.where_type(@type).each do |property|
            link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            link.clicked do |element, event|
              page = Pike::Elements::Pages::PropertyPage.new(@object, @type, property)
              page.removed do |element, _event|
                _event.update_element(self)
              end
              page.show(event)
            end
            @links[property] = link
          end
        end
        super(format)
      end

    end

  end

end
