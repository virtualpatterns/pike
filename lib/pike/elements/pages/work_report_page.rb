require 'rubygems'
require 'bundler/setup'

require 'ruby_app'
require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/models'

      class WorkReportPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(date = Date.today)
          super()

          self.swiped do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::Calendars::MonthDialog.new(event.today, @work_report.date)) do |_event, response|
              @work_report.date = response
              _event.update_text('div[data-role="header"] h1', RubyApp::Language.locale.strftime(@work_report.date, Pike::Application.configuration.format.date.short))
              _event.update_element(@work_report)
            end
          end

          @back_button = Pike::Elements::Navigation::BackButton.new

          @export_button = RubyApp::Elements::Mobile::Button.new
          @export_button.attributes.merge!('class' => 'ui-btn-right')
          @export_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Export', 'You will receive an email with a link to your weekly summary momentarily.')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  Pike::System::Actions::WorkReportExportAction.create!(:user => Pike::Session.identity.user,
                                                                        :date => @work_report.date)
                end
              end
            end
          end

          @work_report = Pike::Elements::WorkReport.new(date)

        end

      end

    end

  end

end
