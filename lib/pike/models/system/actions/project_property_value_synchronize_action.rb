require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ProjectPropertyValueSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :value, :class_name => 'Pike::ProjectPropertyValue'

        def delete_value(value)
          value.destroy
        end

      end

    end

  end

end
