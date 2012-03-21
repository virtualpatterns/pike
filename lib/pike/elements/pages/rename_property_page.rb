require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements/pages/properties_page'
      require 'pike/models'

      class RenamePropertyPage < Pike::Elements::Pages::PropertiesPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @cancel_button = RubyApp::Elements::Navigation::BackButton.new

          @done_button = RubyApp::Elements::Button.new
          @done_button.clicked do |element, event|
            if @from_property_input.value.blank? || @to_property_input.value.blank?
              Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new('Rename Property',
                                                                                             'From and to values are both required.'))
            else
              Pike::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new('Confirm', "Are you sure you want to change the name of the property '#{@from_property_input.value}' to '#{@to_property_input.value}'?")) do |_event, response|
                if response
                  RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(_event) do
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
                    Pike::Session.pages.pop
                    _event.refresh
                  end
                end
              end
            end
          end

          @from_property_input = RubyApp::Elements::Input.new
          @to_property_input = RubyApp::Elements::Input.new

        end

      end

    end

  end

end
