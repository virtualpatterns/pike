require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

require 'ruby_app/elements/list'

module Pike

  module Elements
    require 'pike/elements/pages/work_page'
    require 'pike/models'
    require 'pike/session'

    class WorkList < RubyApp::Elements::List

      class Item

        attr_reader :date, :task, :work

        def initialize(date, task)
          @date = date
          @task = task
          @work = task.work.where_date(@date).first
        end

        def work
          @work ||= Pike::Session.identity.user.work.create!(:task => @task, :date => @date)
        end

        def started?
          @work && @work.started?
        end

      end

      template_path(:all, File.dirname(__FILE__))

      attr_accessor :date

      def initialize
        super

        @date = Date.today

        self.selected do |element, event|
          if self.date.today?
            Pike::Session.identity.user.work.where_started.except(event.item.work).each { |work| work.finish! }
            event.item.work.start!
            event.update_element(self)
          else
            Pike::Session.pages.push(Pike::Elements::Pages::WorkPage.new(event.item.work))
            event.refresh
          end
        end

      end

      def update_duration(event)
        Pike::Session.identity.user.work.where_started.each do |work|
          work.update_duration!
          event.update_text("div.work[work_id='#{work.id}']", ChronicDuration.output(Pike::Work.round_to_minute(work.duration)))
        end
      end

      def render(format)
        self.items = Pike::Session.identity.user.tasks.all.collect { |task| Pike::Elements::WorkList::Item.new(@date, task) } if format == :html
        @flag = nil
        super(format)
      end

    end

  end

end
