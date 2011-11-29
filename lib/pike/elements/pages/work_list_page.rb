require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/calendars/month_dialog'
require 'ruby_app/elements/link'
require 'ruby_app/elements/markdown'
require 'ruby_app/language'

module Pike

  module Elements

    module Pages
      require 'pike/application'
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/task_page'
      require 'pike/elements/work_list'
      require 'pike/session'

      class WorkListPage < Pike::Elements::Pages::BlankPage

        INTERVAL = 60

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @logoff_button = RubyApp::Elements::Button.new
          @logoff_button.clicked do |element, event|
            identity = Pike::Identity.get_identity_by_value(RubyApp::Request.cookies['_identity'])
            identity.destroy!
            event.set_cookie('_identity', nil, Time.now)
            Pike::Session.identity = nil
            Pike::Session.pages.pop
            event.refresh
          end

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
