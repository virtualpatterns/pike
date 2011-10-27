require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/calendars/month_dialog'
require 'ruby_app/elements/link'
require 'ruby_app/language'

module Pike

  module Elements

    module Pages
      require 'pike/application'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/settings_page'
      require 'pike/elements/work_list'
      require 'pike/session'

      class WorkListPage < Pike::Elements::Pages::BlankPage

        INTERVAL = 60

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @date_link = RubyApp::Elements::Link.new
          @date_link.clicked do |element, event|
            Pike::Session.show(event, RubyApp::Elements::Dialogs::Calendars::MonthDialog.new('Select Date', @work_list.date)) do |_event, response|
              if response
                if response > Date.today
                  Pike::Session.show(_event, RubyApp::Elements::Dialogs::MessageDialog.new('Select Date',
                                                                                           'The selected date is invalid.  Work cannot be updated for future dates.'))
                else
                  @work_list.date = response
                  self.interval = @work_list.date.today? ? Pike::Elements::Pages::WorkListPage::INTERVAL : 0
                  _event.refresh
                end
              end
            end
          end

          @settings_button = RubyApp::Elements::Button.new
          @settings_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::SettingsPage.new)
            event.refresh
          end

          @logout_button = RubyApp::Elements::Button.new
          @logout_button.clicked do |element, event|
            Pike::Session.identity = nil
            Pike::Session.pages.pop
            event.refresh
          end

          @work_list = Pike::Elements::WorkList.new

          self.interval = Pike::Elements::Pages::WorkListPage::INTERVAL
          self.triggered do |element, event|
            @work_list.update_duration(event)
          end

        end

      end

    end

  end

end
