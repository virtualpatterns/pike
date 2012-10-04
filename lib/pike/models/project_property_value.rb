module Pike
  require 'pike/models/property_value'

  class ProjectPropertyValue < Pike::PropertyValue

    has_many   :copies,  :class_name => 'Pike::ProjectPropertyValue', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::ProjectPropertyValue', :inverse_of => :copies

    belongs_to :project, :class_name => 'Pike::Project'

  end

end
