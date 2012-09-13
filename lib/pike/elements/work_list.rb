require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/models'

    class WorkList < RubyApp::Elements::Mobile::List

      class WorkListFriendshipListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon'  => 'arrow-r',
                                 'data-theme' => 'e')
        end

      end

      class WorkListTotalDivider < RubyApp::Elements::Mobile::List::ListDivider

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :date

        def initialize(date = Date.today)
          super(nil)

          @date = date

        end

      end

      class WorkListStartedDivider < RubyApp::Elements::Mobile::List::ListDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super('Started')
        end

      end

      class WorkListFlagDivider < RubyApp::Elements::Mobile::List::ListDivider

        template_path(:all, File.dirname(__FILE__))

        def initialize(flag)
          super(Pike::Task::FLAG_NAMES[flag])
        end

      end

      class WorkListAddTaskItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class WorkListWorkItem < RubyApp::Elements::Mobile::List::ListSplitItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(date, task, work)
          super({:date => date,
                 :task => task,
                 :work => work})

          self.attributes.merge!('class' => 'work-list-item')

        end

      end

      class WorkListStartedWorkItem < Pike::Elements::WorkList::WorkListWorkItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(date, task, work)
          super(date, task, work)
          self.attributes.merge!('data-theme' => 'b')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      attr_accessor :today
      attr_accessor :date

      def initialize(today = Date.today, date = Date.today)
        super()

        self.attributes.merge!('class'              => 'work-list',
                               'data-divider-theme' => 'd',
                               'data-split-theme'   => 'd',
                               'data-theme'         => 'd')

        @today = today
        @date = date

      end

      def today?
        @date == @today
      end

      def update!(event)
        @today = event.today
        Pike::Session.identity.user.work.where_started.each do |work|
          if work.date == self.today
            work.update_duration!
            if work.duration_minutes > 0
              event.update_style("span[data-work='#{work.id}']", 'display', 'block')
              event.update_text("span[data-work='#{work.id}']", ChronicDuration.output(work.duration_minutes))
              event.update_text('span.total', "Total: #{ChronicDuration.output(Pike::Session.identity.user.get_work_duration_minutes(@date))}")
            end
          else
            work.finish!
            event.update_element(self)
          end
        end
      end

      def render(format)
        if format == :html

          self.items.clear

          self.items.push(Pike::Elements::WorkList::WorkListFriendshipListItem.new) if Pike::Session.identity.user.introductions_as_target.exists?

          self.items.push(Pike::Elements::WorkList::WorkListTotalDivider.new(@date))

          self.items.push(Pike::Elements::WorkList::WorkListAddTaskItem.new)

          Pike::Session.identity.user.work.where_date(@date).where_started.each_with_index do |work, index|
            work.update_duration!
            self.items.push(Pike::Elements::WorkList::WorkListStartedDivider.new) if index == 0
            self.items.push(Pike::Elements::WorkList::WorkListStartedWorkItem.new(@date, work.task, work))
          end

          _work = {}
          Pike::Session.identity.user.work.where_date(@date).each do |work|
            _work[work.task] = work
          end

          flag = nil
          Pike::Session.identity.user.tasks.all.each do |task|
            work = _work[task] || Pike::Session.identity.user.work.create!(:task => task, :date => @date)
            unless work.started?
              self.items.push(Pike::Elements::WorkList::WorkListFlagDivider.new(task.flag)) unless task.flag == flag
              self.items.push(Pike::Elements::WorkList::WorkListWorkItem.new(@date, work.task, work))
              flag = task.flag
            end
          end

        end
        super(format)
      end

    end

  end

end
