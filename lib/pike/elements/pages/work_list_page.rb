require 'rubygems'
require 'bundler/setup'

require 'ruby_app'
require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/introduction_view_page'
      require 'pike/elements/pages/more_page'
      require 'pike/elements/pages/task_page'

      class WorkListPage < Pike::Elements::Pages::BlankPage

        INTERVAL = 75

        template_path(:all, File.dirname(__FILE__))

        def initialize(today = Date.today, date = Date.today)
          super()

          @more_button = RubyApp::Elements::Button.new
          @more_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::MorePage.new)
            event.refresh
          end

          @date_link = RubyApp::Elements::Link.new
          @date_link.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::Calendars::MonthDialog.new('Select Date', today, @work_list.date, @work_list.date)) do |_event, response|
              if response
                if response > today
                  Pike::Session.show_dialog(_event, RubyApp::Elements::Dialogs::MessageDialog.new('Select Date',
                                                                                                  'The selected date is invalid.  Work cannot be updated for future dates.'))
                else
                  @work_list.date = response
                  self.interval = @work_list.date.today? ? Pike::Elements::Pages::WorkListPage::INTERVAL : 0
                  _event.refresh
                end
              end
            end
          end

          @add_task_button = RubyApp::Elements::Button.new
          @add_task_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::TaskPage.new(Pike::Session.identity.user.tasks.new))
            event.refresh
          end

          @content = RubyApp::Elements::Markdown.new
          @content.clicked do |element, event|
            case event.name
              when 'add_task'
                Pike::Session.pages.push(Pike::Elements::Pages::TaskPage.new(Pike::Session.identity.user.tasks.new))
                event.refresh
            end
          end

          @introduction_list = Pike::Elements::IntroductionList.new
          @introduction_list.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::IntroductionViewPage.new(event.item))
            event.refresh
          end

          @work_list = Pike::Elements::WorkList.new(today, date)

          self.interval = Pike::Elements::Pages::WorkListPage::INTERVAL
          self.triggered do |element, event|
            @work_list.update_duration!(event)
          end

        end

      end

    end

  end

end
