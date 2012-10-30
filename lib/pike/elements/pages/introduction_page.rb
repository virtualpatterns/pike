require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/user_select_page'

      class IntroductionPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(introduction)
          super()

          @introduction = introduction

          @back_button = Pike::Elements::Navigation::BackButton.new

          @done_button = Pike::Elements::Navigation::DoneButton.new
          @done_button.clicked do |element, event|
            RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event) do
              @introduction.save!
              self.hide(event)
            end
          end

          @user_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @user_link.clicked do |element, event|
            page = Pike::Elements::Pages::UserSelectPage.new(@introduction)
            page.removed do |element, _event|
              if @introduction.user_target
                _event.update_text("##{@user_link.element_id} span", @introduction.user_target.name || '(no name)')
                _event.remove_class("##{@user_link.element_id} span", 'ui-disabled')
              else
                _event.update_text("##{@user_link.element_id} span", 'tap to select a user')
                _event.add_class("##{@user_link.element_id} span", 'ui-disabled')
              end
            end
            page.show(event)
          end

          # @user_target_input = Pike::Elements::Inputs::UserInput.new
          # @user_target_input.attributes.merge!('autofocus'   => true,
          #                                      'placeholder' => 'tap to enter a user\'s email')
          # @user_target_input.changed do |element, event|
          #   @introduction.user_target = @user_target_input.user
          # end

          @message_input = Pike::Elements::Inputs::MultilineInput.new
          @message_input.attributes.merge!('placeholder' => 'tap to enter a message')
          @message_input.changed do |element, event|
            @introduction.message = @message_input.value
          end

        end

      end

    end

  end

end
