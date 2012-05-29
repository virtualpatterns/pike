require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'

    class ProjectSelect < RubyApp::Elements::Mobile::List

      class ProjectSelectAddItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super(nil)
          self.attributes.merge!('data-icon' => 'plus')
        end

      end

      class ProjectSelectItem < RubyApp::Elements::Mobile::List::ListItem

        template_path(:all, File.dirname(__FILE__))

        alias :project :item

        def initialize(project)
          super(project)
        end

      end

      class ProjectSelectedItem < Pike::Elements::ProjectSelect::ProjectSelectItem

        template_path(:all, File.dirname(__FILE__))

        alias :project :item

        def initialize(project)
          super(project)
          self.attributes.merge!('data-icon' => 'check')
        end

      end

      template_path(:all, File.dirname(__FILE__))

      def initialize(task)
        super()

        @task = task

        self.attributes.merge!('data-theme' => 'd')

      end

      def render(format)
        if format == :html
          self.items.clear
          self.items.push(Pike::Elements::ProjectSelect::ProjectSelectAddItem.new)
          Pike::Session.identity.user.projects.all.each do |project|
            self.items.push(project == @task.project ?  Pike::Elements::ProjectSelect::ProjectSelectedItem.new(project) : Pike::Elements::ProjectSelect::ProjectSelectItem.new(project))
          end
        end
        super(format)
      end

    end

  end

end
