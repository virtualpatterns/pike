require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module Pike

  module Elements

    module Pages
      require 'pike'
      require 'pike/elements'

      class ActivityListPage < Pike::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @back_button = Pike::Elements::Navigation::BackButton.new

          @activity_list = Pike::Elements::ActivityList.new

        end

      end

    end

  end

end
