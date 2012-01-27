module Pike

  module System

    module Actions

      class SynchronizeAction < Pike::System::Action

        belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :synchronize_actions_as_source
        belongs_to :user_target, :class_name => 'Pike::User', :inverse_of => :synchronize_actions_as_target

      end

    end

  end

end
