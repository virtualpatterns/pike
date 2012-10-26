module Pike
  require 'pike/mixins'
  require 'pike/models/property_value'

  class ActivityPropertyValue < Pike::PropertyValue
    extend Pike::Mixins::IndexMixin

    has_many   :copies,  :class_name => 'Pike::ActivityPropertyValue', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::ActivityPropertyValue', :inverse_of => :copies

    belongs_to :activity, :class_name => 'Pike::Activity'

    scope :where_copy_of, lambda { |value| where(:copy_of_id => value ? value.id : nil) }

    index [[:activity_id,  1],
           [:property_id, 1],
           [:copy_of_id,  1]]

    index [[:copy_of_id, 1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      activity1 = user1.create_activity!('Assert Indexes Activity 1', true)
      activity_value1 = activity1.create_value!('Assert Indexes Activity Property 1', 'Assert Indexes Activity Value 1')
      activity_value2 = activity1.create_value!('Assert Indexes Activity Property 2', 'Assert Indexes Activity Value 2')

      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      activity2 = user2.create_activity!('Assert Indexes Activity 2', false)
      activity_value3 = activity2.create_value!('Assert Indexes Activity Property 3', 'Assert Indexes Activity Value 3')
      friendship1 = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      activity3 = user2.activities.where_copy_of(activity1).first

      self.assert_index(Pike::ActivityPropertyValue.where_property(activity_value1.property))
      self.assert_index(activity1.values.where_property(activity_value1.property))
      self.assert_index(activity3.values.where_copy_of(activity_value1))
      self.assert_index(activity_value1.copies.all)

    end

    def copy?
      return self.copy_of
    end

  end

end
