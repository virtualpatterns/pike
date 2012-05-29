require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'
      require 'pike/elements/pages/project_page'

      class ProjectListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @project_list = Pike::Elements::ProjectList.new
          @project_list.item_clicked do |element, event|
            if event.item.is_a?(Pike::Elements::ProjectList::ProjectListAddItem)
              page = Pike::Elements::Pages::ProjectPage.new(Pike::Session.identity.user.projects.new)
              page.removed do |element, _event|
                _event.update_element(@project_list)
              end
              page.show(event)
            else
              page = Pike::Elements::Pages::ProjectPage.new(event.item.project)
              page.removed do |element, _event|
                _event.update_element(@project_list)
              end
              page.show(event)
            end
          end

        end

      end

    end

  end

end
