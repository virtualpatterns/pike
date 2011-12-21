require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/dialogs/calendars/month_dialog'
require 'ruby_app/elements/dialogs/message_dialog'
require 'ruby_app/elements/link'
require 'ruby_app/elements/navigation/back_button'
require 'ruby_app/language'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'
      require 'pike/session'

      class ReportPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(date = Date.today)
          super()

          @back_button = RubyApp::Elements::Navigation::BackButton.new

          @date = date

          @date_link = RubyApp::Elements::Link.new
          @date_link.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::Calendars::MonthDialog.new('Select Date', @date)) do |_event, response|
              if response
                if response > event.today
                  Pike::Session.show_dialog(_event, RubyApp::Elements::Dialogs::MessageDialog.new('Select Date',
                                                                                           'The selected date is invalid.  The weekly summary cannot be created for future dates.'))
                else
                  @date = response
                  _event.refresh
                end
              end
            end
          end

        end

        def first_date
          @date - @date.wday
        end

      end

    end

  end

end
