module Pike
  require 'pike/mixins'

  class ProjectPropertyValue < Pike::PropertyValue
    extend Pike::Mixins::IndexMixin

    belongs_to :project, :class_name => 'Pike::Project'

    index [[:project_id, 1],
           [:property_id, 1]]

    def self.assert_indexes
      user = Pike::User.get_user_by_url('Assert Indexes User')
      property = user.create_property!(Pike::Property::TYPE_PROJECT, 'Assert Indexes Project Property')
      project = user.create_project!('Assert Indexes Project', true, 'Assert Indexes Project Property' => 'Assert Indexes Project Property Value')

      self.assert_index(project.property_values.where_property(property))

    end

  end

end
