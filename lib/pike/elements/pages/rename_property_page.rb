require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/models'

      class RenamePropertyPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            if @from_property_input.value.blank? || @to_property_input.value.blank?
              RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Rename Property', 'From and to values are both required.'))
            else
              RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', "Are you sure you want to change the name of the property '#{@from_property_input.value}' to '#{@to_property_input.value}'?")) do |_event, response|
                if response
                  RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                    user = Pike::Session.identity.user
                    if user.project_properties.include?(@from_property_input.value)
                      user.pull(:project_properties, @from_property_input.value)
                      user.push(:project_properties, @to_property_input.value)
                      user.projects.all.each do |project|
                        project.rename(@from_property_input.value, @to_property_input.value)
                      end
                    end
                    if user.activity_properties.include?(@from_property_input.value)
                      user.pull(:activity_properties, @from_property_input.value)
                      user.push(:activity_properties, @to_property_input.value)
                      user.activities.all.each do |activity|
                        activity.rename(@from_property_input.value, @to_property_input.value)
                      end
                    end
                    if user.task_properties.include?(@from_property_input.value)
                      user.pull(:task_properties, @from_property_input.value)
                      user.push(:task_properties, @to_property_input.value)
                      user.tasks.all.each do |task|
                        task.rename(@from_property_input.value, @to_property_input.value)
                      end
                    end
                    self.hide(_event)
                  end
                end
              end
            end
          end

          @from_property_input = Pike::Elements::Input.new
          @from_property_input.attributes.merge!('placeholder' => 'tap to enter a from name')

          @to_property_input = Pike::Elements::Input.new
          @to_property_input.attributes.merge!('placeholder' => 'tap to enter a to name')

        end

      end

    end

  end

end
