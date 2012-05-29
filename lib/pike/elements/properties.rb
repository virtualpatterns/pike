require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/navigation/add_button'
    require 'pike/elements/pages/property_page'

    class Properties < RubyApp::Element

      template_path(:all, File.dirname(__FILE__))

      def initialize(properties, object)
        super()

        self.attributes.merge!('data-inset' => 'true',
                               'data-role'  => 'listview',
                               'data-theme' => 'd')

        @user = Pike::Session.identity.user
        @properties = properties
        @object = object

        @add_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
        @add_link.clicked do |element, event|
          page = Pike::Elements::Pages::PropertyPage.new(@properties, @object)
          page.removed do |element, _event|
            _event.update_element(self)
          end
          page.show(event)
        end

      end

      def render(format)
        if format == :html
          @property_links = {}
          @user.send(@properties).each do |property|
            property_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            property_link.clicked do |element, event|
              page = Pike::Elements::Pages::PropertyPage.new(@properties, @object, property)
              page.removed do |element, _event|
                _event.update_element(self)
              end
              page.show(event)
            end
            @property_links[property] = property_link
          end
        end
        super(format)
      end

    end

  end

end
