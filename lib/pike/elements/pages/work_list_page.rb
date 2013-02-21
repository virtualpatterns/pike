require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/more_page'

      class WorkListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(today = Date.today, date = Date.today)
          super()

          self.loaded do |element, event|
            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} event.create_trigger(#{@work_list.element_id.inspect}, #{Pike::Elements::Pages::WorkListPage.configuration.interval})")
            event.create_trigger(self, Pike::Elements::Pages::WorkListPage.configuration.interval)
          end
          self.shown do |element, event|
            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} event.create_trigger(#{self.element_id.inspect}, #{Pike::Elements::Pages::WorkListPage.configuration.interval})")
            event.create_trigger(self, Pike::Elements::Pages::WorkListPage.configuration.interval)
          end
          self.hidden do |element, event|
            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} event.destroy_trigger(#{self.element_id.inspect})")
            event.destroy_trigger(self)
          end

          self.triggered do |element, event|
            @work_list.update!(event)
            event.update_text('div[data-role="header"] h1', RubyApp::Language.locale.strftime(@work_list.date, Pike::Application.configuration.format.date.short))
          end

          self.swiped do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::Calendars::MonthDialog.new(today, @work_list.date)) do |_event, response|
              @work_list.date = response
              _event.update_text('div[data-role="header"] h1', RubyApp::Language.locale.strftime(@work_list.date, Pike::Application.configuration.format.date.short))
              _event.update_element(@work_list)
            end
          end

          @more_button = RubyApp::Elements::Mobile::Navigation::NavigationButton.new
          @more_button.clicked do |element, event|
            page = Pike::Elements::Pages::MorePage.new
            page.removed do |element, _event|
              _event.update_element(@work_list)
            end
            page.show(event)
          end

          @logoff_button = RubyApp::Elements::Mobile::Button.new
          @logoff_button.clicked do |element, event|
            Pike::Session.identity.destroy
            Pike::Session.identity = nil
            RubyApp::Response.set_cookie('identity', {:value    => nil,
                                                      :path     => RubyApp::Application.root,
                                                      :expires  => Time.now})
            self.hide(event)
          end

          @work_list = Pike::Elements::WorkList.new(today, date)

        end

      end

    end

  end

end
