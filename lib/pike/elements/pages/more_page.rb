require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/about_page'
      require 'pike/elements/pages/activity_list_page'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/project_list_page'
      require 'pike/elements/pages/report_page'
      require 'pike/models'
      require 'pike/session'

      class MorePage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @logoff_button = RubyApp::Elements::Button.new
          @logoff_button.clicked do |element, event|
            identity = Pike::Identity.get_identity_by_value(RubyApp::Request.cookies['_identity'])
            identity.destroy! if identity
            event.set_cookie('_identity', nil, Time.now)
            Pike::Session.identity = nil
            Pike::Session.pages.pop(2)
            event.refresh
          end

          @project_list_link = RubyApp::Elements::Link.new
          @project_list_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectListPage.new)
            event.refresh
          end

          @activity_list_link = RubyApp::Elements::Link.new
          @activity_list_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivityListPage.new)
            event.refresh
          end

          @report_link = RubyApp::Elements::Link.new
          @report_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ReportPage.new(event.today))
            event.refresh
          end

          @about_link = RubyApp::Elements::Link.new
          @about_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::AboutPage.new)
            event.refresh
          end

        end

      end

    end

  end

end
