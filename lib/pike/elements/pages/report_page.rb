require 'rubygems'
require 'bundler/setup'

require 'ruby_app'
require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements/pages/blank_page'

      class ReportPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(date = Date.today)
          super()

          @date = date

          @back_button = RubyApp::Elements::Navigation::BackButton.new

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

          @export_button = RubyApp::Elements::Button.new
          @export_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::AcknowledgementDialog.new('Export', 'You will receive an email with a link to your weekly summary momentarily.')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  Pike::System::Actions::ReportExportAction.create!(:user => Pike::Session.identity.user,
                                                                    :date => @date)
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
