require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class PropertySynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :property, :class_name => 'Pike::Property'

      end

    end

  end

end
