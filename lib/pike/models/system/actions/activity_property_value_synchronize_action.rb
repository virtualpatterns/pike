require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike/models/system/actions/synchronize_action'

      class ActivityPropertyValueSynchronizeAction < Pike::System::Actions::SynchronizeAction

        belongs_to :value, :class_name => 'Pike::ActivityPropertyValue'

        def delete_value(value)
          value.destroy
        end

      end

    end

  end

end
