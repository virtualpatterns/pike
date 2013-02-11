require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    class Document < RubyApp::Elements::Mobile::Platforms::Ios::Document

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super

        self.stylesheets.push('pike/resources/themes/Pike.min.css')
        self.stylesheets.push('https://code.jquery.com/mobile/1.1.0/jquery.mobile.structure-1.1.0.min.css')

        self.metadata.merge!('apple-mobile-web-app-status-bar-style' => 'black')

        self.links.merge!('apple-touch-icon'          => '/pike/resources/elements/document/apple-touch-icon.png',
                          'apple-touch-startup-image' => '/pike/resources/elements/document/apple-touch-startup-image.png')

        require 'pike/elements/pages/default_page'
        self.pages.push(Pike::Elements::Pages::DefaultPage.new)

      end

    end

  end

end
