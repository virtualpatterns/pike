require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements/button'
require 'ruby_app/elements/dialogs/confirmation_dialog'
require 'ruby_app/elements/dialogs/exception_dialog'
require 'ruby_app/elements/input'
require 'ruby_app/elements/link'
require 'ruby_app/elements/navigation/back_button'

module Pike

  module Elements

    module Pages
      require 'pike/elements/pages/activity_property_page'
      require 'pike/elements/pages/properties_page'
      require 'pike/session'

      class ActivityPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize(activity)
          super()

          @user = Pike::Session.identity.user
          @activity = activity

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
              @activity.save!
              Pike::Session.pages.pop
              event.refresh
            end
          end

          @name_input = RubyApp::Elements::Input.new
          @name_input.value = @activity.name
          @name_input.changed do |element, event|
            @activity.name = @name_input.value
          end

          @add_button = RubyApp::Elements::Button.new
          @add_button.clicked do |element, event|
            Pike::Session.pages.push(Pike::Elements::Pages::ActivityPropertyPage.new(@activity))
            event.refresh
          end

          @delete_button = RubyApp::Elements::Button.new
          @delete_button.clicked do |element, event|
            Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this activity?')) do |_event, response|
              if response
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
                  @activity.destroy!
                  Pike::Session.pages.pop
                  _event.refresh
                end
              end
            end
          end

        end

        def render(format)
          if format == :html
            @property_links = {}
            @user.activity_properties.each do |property|
              property_link = RubyApp::Elements::Link.new
              property_link.clicked do |element, event|
                Pike::Session.pages.push(Pike::Elements::Pages::ActivityPropertyPage.new(@activity, property))
                event.refresh
              end
              @property_links[property] = property_link
            end
          end
          super(format)
        end

      end

    end

  end

end
