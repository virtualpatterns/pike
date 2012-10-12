module Pike
  require 'pike/mixins'
  require 'pike/models/property_value'

  class ProjectPropertyValue < Pike::PropertyValue
    extend Pike::Mixins::IndexMixin

    has_many   :copies,  :class_name => 'Pike::ProjectPropertyValue', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::ProjectPropertyValue', :inverse_of => :copies

    belongs_to :project, :class_name => 'Pike::Project'

    scope :where_copy_of, lambda { |value| where(:copy_of_id => value ? value.id : nil) }

    index [[:project_id,  1],
           [:property_id, 1],
           [:copy_of_id,  1]]

    index [[:copy_of_id, 1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      project1 = user1.create_project!('Assert Indexes Project 1', true)
      project_value1 = project1.create_value!('Assert Indexes Project Property 1', 'Assert Indexes Project Value 1')
      project2 = user1.create_project!('Assert Indexes Project 2', true)
      project_value2 = project2.create_value!('Assert Indexes Project Property 1', 'Assert Indexes Project Value 2')
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      project3 = user2.projects.where_copy_of(project1).first

      self.assert_index(Pike::ProjectPropertyValue.where_property(project_value1.property))
      self.assert_index(project1.values.where_property(project_value1.property))
      self.assert_index(project3.values.where_copy_of(project_value1))
      self.assert_index(project_value1.copies.all)

    end

    def copy?
      return self.copy_of
    end


  end

end
