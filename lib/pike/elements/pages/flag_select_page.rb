module Pike

  module Elements

    module Pages
      require 'pike/session'
      require 'pike/elements/pages/select_page'
      require 'pike/elements/flag_select'

      class FlagSelectPage < Pike::Elements::Pages::SelectPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(task)
          super()

          @task = task

          @flag_select = Pike::Elements::FlagSelect.new
          @flag_select.selected_item = @task.flag
          @flag_select.clicked do |element, event|
            @task.flag = @flag_select.selected_item
            Pike::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
