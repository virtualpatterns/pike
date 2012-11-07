module Pike
  require 'pike/mixins'
  require 'pike/models/property_value'

  class TaskPropertyValue < Pike::PropertyValue
    extend Pike::Mixins::IndexMixin

    belongs_to :task, :class_name => 'Pike::Task'

    scope :where_task, lambda { |task| where(:task_id => task ? task.id : nil) }

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      task1 = user1.create_task!('Assert Indexes Project 1', 'Assert Indexes Activity 1')
      task_value1 = task1.create_value!('Assert Indexes Task Property 1', 'Assert Indexes Task Value 1')
      task_value2 = task1.create_value!('Assert Indexes Task Property 2', 'Assert Indexes Task Value 2')

      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      task2 = user2.create_task!('Assert Indexes Project 2', 'Assert Indexes Activity 2')
      task_value3 = task2.create_value!('Assert Indexes Task Property 3', 'Assert Indexes Task Value 3')
      friendship1 = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      self.assert_index(Pike::TaskPropertyValue.where_property(task_value1.property))
      self.assert_index(Pike::TaskPropertyValue.where_task(task1))
      self.assert_index(task1.values.where_property(task_value1.property))

    end

    def copy?
      return false
    end

  end

end
