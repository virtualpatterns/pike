require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class FlagSelectPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @back_button = Pike::Elements::Navigation::BackButton.new

          @flag_select = Pike::Elements::FlagSelect.new(@task)
          @flag_select.item_clicked do |element, event|
            @task.flag = event.item.flag
            self.hide(event, @back_button.options)
          end

        end

      end

    end

  end

end
