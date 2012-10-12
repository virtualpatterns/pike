module Pike
  require 'pike/mixins'
  require 'pike/models/property_value'

  class TaskPropertyValue < Pike::PropertyValue
    extend Pike::Mixins::IndexMixin

    belongs_to :task, :class_name => 'Pike::Task'

    scope :where_task, lambda { |task| where(:task_id => task ? task.id : nil) }

    index [[:task_id,     1],
           [:property_id, 1]]

    def self.assert_indexes
      user = Pike::User.get_user_by_url('Assert Indexes User')
      task1 = user.create_task!('Assert Indexes Project 1', 'Assert Indexes Activity 1')
      task_value1 = task1.create_value!('Assert Indexes Task Property 1', 'Assert Indexes Task Value 1')
      task2 = user.create_task!('Assert Indexes Project 2', 'Assert Indexes Activity 2')
      task_value2 = task1.create_value!('Assert Indexes Task Property 1', 'Assert Indexes Task Value 1')

      self.assert_index(Pike::TaskPropertyValue.where_property(task_value1.property))
      self.assert_index(Pike::TaskPropertyValue.where_task(task1))
      self.assert_index(task1.values.where_property(task_value1.property))

    end

    def copy?
      return false
    end

  end

end
