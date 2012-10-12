require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class ProjectListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @project_list = Pike::Elements::ProjectList.new

        end

      end

    end

  end

end
