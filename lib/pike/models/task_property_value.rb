module Pike
  require 'pike/models/property_value'

  class TaskPropertyValue < Pike::PropertyValue

    belongs_to :task, :class_name => 'Pike::Task'

    def copy?
      return false
    end

  end

end
