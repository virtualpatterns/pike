require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/exception_dialog'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/blank_page'
      require 'pike/elements/pages/work_list_page'
      require 'pike/elements/started_work_list'
      require 'pike/session'

      class StartedWorkListPage < Pike::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          self.loaded do |element, event|
            if Pike::Session.identity.user.work.where_started.where_not_date(Date.today).count <= 0
              Pike::Session.pages.pop
              Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new)
              event.refresh
            end
          end

          @continue_button = RubyApp::Elements::Button.new
          @continue_button.clicked do |element, event|
            begin
              Pike::Session.identity.user.work.where_started.where_not_date(Date.today).each do |work|
                work.finish!
              end
              Pike::Session.pages.pop
              Pike::Session.pages.push(Pike::Elements::Pages::WorkListPage.new)
              event.refresh
            rescue Exception => exception
              Pike::Session.show(event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
            end
          end

          @started_work_list = Pike::Elements::StartedWorkList.new

        end

      end

    end

  end

end
