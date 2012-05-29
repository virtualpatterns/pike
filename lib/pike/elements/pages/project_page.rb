require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class ProjectPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(project)
          super()

          @project = project

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @project.save!
              self.hide(event)
            end
          end

          @name_input = Pike::Elements::Input.new
          @name_input.attributes.merge!('disabled'    => @project.copy_of ? true : false,
                                        'placeholder' => 'tap to enter a name')
          @name_input.value = @project.name
          @name_input.changed do |element, event|
            @project.name = @name_input.value
          end

          @is_shared_input = Pike::Elements::Inputs::ToggleInput.new
          @is_shared_input.attributes.merge!('disabled' => @project.copy_of ? true : false)
          @is_shared_input.value = @project.is_shared
          @is_shared_input.changed do |element, event|
            @project.is_shared = @is_shared_input.value
          end

          @properties = Pike::Elements::Properties.new(:project_properties, @project)

          @delete_button = RubyApp::Elements::Mobile::Button.new
          @delete_button.attributes.merge!('data-theme' => 'f')
          @delete_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirm', 'Are you sure you want to delete this project?')) do |_event, response|
              if response
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(_event) do
                  @project.destroy
                  self.hide(_event, @done_button.options)
                end
              end
            end
          end

        end

      end

    end

  end

end
