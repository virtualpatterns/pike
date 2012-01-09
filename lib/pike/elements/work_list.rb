require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'
require 'ruby-event'

require 'ruby_app/elements/list'
require 'ruby_app/log'

module Pike

  module Elements
    require 'pike/elements/pages/work_page'
    require 'pike/models'
    require 'pike/session'

    class WorkList < RubyApp::Elements::List

      class StartedEvent < RubyApp::Elements::List::ClickedEvent

        def initialize(data)
          super(data)
        end

      end

      class EditedEvent < RubyApp::Elements::List::ClickedEvent

        def initialize(data)
          super(data)
        end

      end

      class Item

        attr_reader :date, :task, :work

        def initialize(date, task, work)
          @date = date
          @task = task
          @work = work || Pike::Session.identity.user.work.create!(:task => @task, :date => @date)
        end

      end

      template_path(:all, File.dirname(__FILE__))
      exclude_parent_template(:html, :css, :js)

      attr_accessor :today, :date

      event :started
      event :edited

      def initialize(today = Date.today, date = Date.today)
        super()

        @today = today
        @date = date

        self.started do |element, event|
          unless event.item.work.started?
            Pike::Session.identity.user.work.where_started.each { |work| work.finish! }
            event.item.work.start!
          else
            Pike::Session.identity.user.work.where_started.each { |work| work.finish! }
          end
          event.update_element(self)
        end

        self.edited do |element, event|
          event.item.work.update_duration!
          Pike::Session.pages.push(Pike::Elements::Pages::WorkPage.new(event.item.work))
          event.refresh
        end

      end

      def today?
        @date == @today
      end

      def update_duration!(event)
        @today = event.today
        Pike::Session.identity.user.work.where_started.each do |work|
          if work.date == self.today
            work.update_duration!
            event.remove_class("div.work[work_id='#{work.id}']", 'blank')
            event.update_text("div.work[work_id='#{work.id}']", ChronicDuration.output(work.duration || 0))
            event.update_text('span.total', ChronicDuration.output(self.items.inject(0) { |total, item| total + ( item.work.reload.duration || 0 ) }))
          else
            work.finish!
            event.update_element(self)
          end
        end
      end

      def render(format)
        if format == :html
          RubyApp::Log.duration("#{self.class}##{__method__}") do
            work = {}
            Pike::Session.identity.user.work.where_date(@date).each do |_work|
              work[_work.task] = _work
            end
            self.items = Pike::Session.identity.user.tasks.all.collect do |task|
              Pike::Elements::WorkList::Item.new(@date, task, work[task])
            end
            @flag = nil
          end
        end
        super(format)
      end

      protected

        def on_event(event)
          on_started(event) if event.is_a?(Pike::Elements::WorkList::StartedEvent)
          on_edited(event) if event.is_a?(Pike::Elements::WorkList::EditedEvent)
          super(event)
        end

        def on_started(event)
          started(event)
        end

        def on_edited(event)
          edited(event)
        end

    end

  end

end
