require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

require 'ruby_app/elements'

module Pike

  module Elements
    require 'pike'
    require 'pike/elements/pages/task_page'
    require 'pike/elements/pages/work_page'
    require 'pike/models'

    class WorkReport < RubyApp::Element

      template_path(:all, File.dirname(__FILE__))

      attr_accessor :date

      def initialize(date = Date.today)
        super()

        self.attributes.merge!('data-divider-theme' => 'd',
                               'data-role'          => 'listview',
                               'data-split-theme'   => 'd',
                               'data-theme'         => 'd')

        @date = date

      end

    end

  end

end
