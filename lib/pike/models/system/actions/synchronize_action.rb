module Pike

  module System

    module Actions

      class SynchronizeAction < Pike::System::Action

        belongs_to :user_source, :class_name => 'Pike::User'
        belongs_to :user_target, :class_name => 'Pike::User'

      end

    end

  end

end
