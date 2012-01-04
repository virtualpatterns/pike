require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/inputs/duration_input'
require 'ruby_app/elements/link'
require 'ruby_app/elements/navigation/back_button'
require 'ruby_app/language'

module Pike

  module Elements

    module Pages
      require 'pike/application'
      require 'pike/elements/pages/activity_select_page'
      require 'pike/elements/pages/flag_select_page'
      require 'pike/elements/pages/project_select_page'
      require 'pike/elements/pages/properties_page'
      require 'pike/elements/properties'
      require 'pike/session'

      class WorkPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(work)
          super()

          @work = work

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              @work.task.save!
              @work.save!
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @project_link = RubyApp::Elements::Link.new
          @project_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ProjectSelectPage.new(@work.task))
            event.refresh
          end

          @activity_link = RubyApp::Elements::Link.new
          @activity_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivitySelectPage.new(@work.task))
            event.refresh
          end

          @flag_link = RubyApp::Elements::Link.new
          @flag_link.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::FlagSelectPage.new(@work.task))
            event.refresh
          end

          @duration_input = RubyApp::Elements::Inputs::DurationInput.new
          @duration_input.duration = @work.duration || 0
          @duration_input.changed do |element, event|
            @work.duration = @duration_input.duration || 0
          end

          @properties = Pike::Elements::Properties.new(:task_properties, @work.task)

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this task?')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @work.finish! if @work.started?
                  @work.task.destroy!
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

        end

      end

    end

  end

end
