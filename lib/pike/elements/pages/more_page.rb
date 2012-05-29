require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/about_page'
      require 'pike/elements/pages/activity_list_page'
      #require 'pike/elements/pages/friend_list_page'
      require 'pike/elements/pages/project_list_page'
      #require 'pike/elements/pages/rename_property_page'
      require 'pike/elements/pages/work_report_page'
      require 'pike/models'

      class MorePage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @project_list_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @project_list_link.clicked do |element, event|
            Pike::Elements::Pages::ProjectListPage.new.show(event)
          end

          @activity_list_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @activity_list_link.clicked do |element, event|
            Pike::Elements::Pages::ActivityListPage.new.show(event)
          end

          @friend_list_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @friend_list_link.clicked do |element, event|
            #Pike::Session.pages.push(Pike::Elements::Pages::FriendListPage.new)
            #event.refresh
          end

          @work_report_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @work_report_link.clicked do |element, event|
            Pike::Elements::Pages::WorkReportPage.new.show(event)
          end

          @rename_property_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @rename_property_link.clicked do |element, event|
            #Pike::Session.pages.push(Pike::Elements::Pages::RenamePropertyPage.new)
            #event.refresh
          end

          @about_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @about_link.clicked do |element, event|
            Pike::Elements::Pages::AboutPage.new(event.now).show(event)
          end

        end

      end

    end

  end

end
