require 'rubygems'
require 'bundler/setup'

require 'ruby_app/element'
require 'ruby_app/elements/button'
require 'ruby_app/elements/link'

module Pike

  module Elements
    require 'pike/elements/pages/property_page'
    require 'pike/session'

    class Properties < RubyApp::Element

      template_path(:all, File.dirname(__FILE__))

      def initialize(properties, object)
        super()

        @user = Pike::Session.identity.user
        @properties = properties
        @object = object

        @add_button = RubyApp::Elements::Button.new
        @add_button.clicked do |element, event|
          Pike::Session.pages.push(Pike::Elements::Pages::PropertyPage.new(@properties, @object))
          event.refresh
        end

      end

      def render(format)
        if format == :html
          @property_links = {}
          @user.send(@properties).each do |property|
            property_link = RubyApp::Elements::Link.new
            property_link.clicked do |element, event|
              Pike::Session.pages.push(Pike::Elements::Pages::PropertyPage.new(@properties, @object, property))
              event.refresh
            end
            @property_links[property] = property_link
          end
        end
        super(format)
      end

    end

  end

end
