require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/page'

      class ActivityPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(activity)
          super()

          @activity = activity

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @activity.save!
              self.hide(event)
            end
          end

          @name_input = Pike::Elements::Input.new
          @name_input.attributes.merge!('autofocus'   => @activity.copy? ? false : true,
                                        'disabled'    => @activity.copy? ? true : false,
                                        'placeholder' => 'tap to enter a name')
          @name_input.value = @activity.name
          @name_input.changed do |element, event|
            @activity.name = @name_input.value
          end

          @is_shared_input = Pike::Elements::Inputs::ToggleInput.new
          @is_shared_input.attributes.merge!('disabled' => @activity.copy? ? true : false)
          @is_shared_input.value = @activity.is_shared
          @is_shared_input.changed do |element, event|
            @activity.is_shared = @is_shared_input.value
          end

          @save_link = RubyApp::Elements::Mobile::Link.new
          @save_link.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @activity.save!
              event.update_style('p.instructions.new', 'display', 'none')
              event.update_element(@property_value_list)
              event.update_style('div.delete', 'display', 'block')
            end
          end

          @property_value_list = Pike::Elements::PropertyValueList.new(@activity, Pike::Property::TYPE_ACTIVITY)

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this activity?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @activity.destroy
                  self.hide(_event)
                end
              end
            end
          end

        end

      end

    end

  end

end
