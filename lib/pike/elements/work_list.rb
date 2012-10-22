require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'
require 'oauth2'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/documents/authentication/o_auth/git_hub_token_document'
    require 'pike/elements/pages/friendship_list_page'
    require 'pike/elements/pages/message_list_page'
    require 'pike/elements/pages/task_page'
    require 'pike/elements/pages/work_page'
    require 'pike/models'

    class WorkList < RubyApp::Elements::Mobile::List

      class WorkListWelcomeItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('class'      => 'work-list-welcome-item',
                                 'data-icon'  => 'false',
                                 'data-theme' => 'b')
        end

      end

      class WorkListMessageItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon'  => 'arrow-r',
                                 'data-theme' => 'e')
        end

      end

      class WorkListImportItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon'  => 'arrow-r',
                                 'data-theme' => 'e')
        end

      end

      class WorkListFriendshipItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

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

      class WorkListItem < RubyApp::Elements::Mobile::List::ListSplitItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(date, task, work)
          super({:date => date,
                 :task => task,
                 :work => work})

          self.attributes.merge!('class' => 'work-list-item')

        end

      end

      class WorkListStartedItem < Pike::Elements::WorkList::WorkListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize(date, task, work)
          super(date, task, work)
          self.attributes.merge!('data-theme' => 'b')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      attr_accessor :today
      attr_accessor :date
      attr_reader :count

      def initialize(today = Date.today, date = Date.today)
        super()

        self.attributes.merge!('class'              => 'work-list',
                               'data-divider-theme' => 'd',
                               'data-split-theme'   => 'd',
                               'data-theme'         => 'd')

        @today = today
        @date = date
        @count = 0

        self.item_clicked do |element, event|
          @today = event.today
          if event.item.is_a?(Pike::Elements::WorkList::WorkListMessageItem)
            page = Pike::Elements::Pages::MessageListPage.new
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          elsif event.item.is_a?(Pike::Elements::WorkList::WorkListImportItem)
            unless Pike::Session.identity.token.is_a?(::OAuth2::AccessToken)
              Pike::Elements::Documents::Authentication::OAuth::GitHubTokenDocument.new.show(event)
            else
              RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
                Pike::Session.identity.import_tasks!
                event.update_element(self)
              end
            end
          elsif event.item.is_a?(Pike::Elements::WorkList::WorkListFriendshipItem)
            page = Pike::Elements::Pages::FriendshipListPage.new
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          elsif event.item.is_a?(Pike::Elements::WorkList::WorkListAddTaskItem)
            page = Pike::Elements::Pages::TaskPage.new(Pike::Session.identity.user.tasks.new)
            page.removed do |element, _event|
              _event.update_element(self)
            end
            page.show(event)
          elsif event.item.is_a?(Pike::Elements::WorkList::WorkListItem)
            if self.today?
              unless event.item.item.work.started?
                Pike::Session.identity.user.work.where_started.each { |work| work.finish! }
                event.item.item.work.start!
              else
                Pike::Session.identity.user.work.where_started.each { |work| work.finish! }
              end
              event.update_element(self)
            else
              event.item.item.work.reload
              page = Pike::Elements::Pages::WorkPage.new(event.item.item)
              page.removed do |element, _event|
                _event.update_element(self)
              end
              page.show(event)
            end
          end
        end
        self.link_clicked do |element, event|
          @today = event.today
          event.item.item.work.reload
          page = Pike::Elements::Pages::WorkPage.new(event.item.item)
          page.removed do |element, _event|
            _event.update_element(self)
          end
          page.show(event)
        end

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

          self.items.push(Pike::Elements::WorkList::WorkListWelcomeItem.new) if @count < 1

          @count += 1

          self.items.push(Pike::Elements::WorkList::WorkListMessageItem.new) if Pike::Session.identity.user.messages.exists?
          self.items.push(Pike::Elements::WorkList::WorkListImportItem.new) if Pike::Session.identity.source?(Pike::System::Identity::SOURCE_GITHUB) unless Pike::Session.identity.user.projects.exists?
          self.items.push(Pike::Elements::WorkList::WorkListFriendshipItem.new) if Pike::Session.identity.user.introductions_as_target.exists?

          self.items.push(Pike::Elements::WorkList::WorkListTotalDivider.new(@date))

          self.items.push(Pike::Elements::WorkList::WorkListAddTaskItem.new)

          Pike::Session.identity.user.work.where_date(@date).where_started.each_with_index do |work, index|
            work.update_duration!
            self.items.push(Pike::Elements::WorkList::WorkListStartedDivider.new) if index == 0
            self.items.push(Pike::Elements::WorkList::WorkListStartedItem.new(@date, work.task, work))
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
              self.items.push(Pike::Elements::WorkList::WorkListItem.new(@date, work.task, work))
              flag = task.flag
            end
          end

        end
        super(format)
      end

    end

  end

end
