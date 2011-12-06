require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'
require 'ruby-event'

require 'ruby_app/elements/list'

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

        def initialize(date, task)
          @date = date
          @task = task
          @work = task.work.where_date(@date).first
        end

        def worked?
          @work
        end

        def started?
          @work && @work.started?
        end

        def work
          @work ||= Pike::Session.identity.user.work.create!(:task => @task, :date => @date)
        end

        def self.total_duration(items)
          value = 0
          items.each do |item|
            if item.worked?
              item.work.update_duration!
              value += item.work.duration
            end
          end
          value
        end

      end

      template_path(:all, File.dirname(__FILE__))
      exclude_parent_template(:html, :css, :js)

      attr_accessor :date

      event :started
      event :edited

      def initialize
        super

        @date = Date.today

        self.started do |element, event|
          Pike::Session.identity.user.work.where_started.except(event.item.work).each { |work| work.finish! }
          unless event.item.work.started?
            event.item.work.start!
          else
            event.item.work.finish!
          end
          event.update_element(self)
        end

        self.edited do |element, event|
          Pike::Session.pages.push(Pike::Elements::Pages::WorkPage.new(event.item.work))
          event.refresh
        end

      end

      def today?
        @date == Date.today
      end

      def update_duration(event)
        updated = false
        Pike::Session.identity.user.work.where_started.each do |work|
          if work.date == event.now.to_date
            work.update_duration!
            event.update_text("div.work[work_id='#{work.id}']", ChronicDuration.output(Pike::Work.round_to_minute(work.duration)))
            event.update_text('span.total', ChronicDuration.output(Pike::Work.round_to_minute(Pike::Elements::WorkList::Item.total_duration(self.items))))
          else
            work.finish!
            unless updated
              event.update_element(self)
              updated = true
            end
          end
        end
      end

      def render(format)
        if format == :html
          self.items = Pike::Session.identity.user.tasks.all.collect do |task|
            Pike::Elements::WorkList::Item.new(@date, task)
          end
          @flag = nil
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
