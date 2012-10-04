module Pike
  require 'pike/models/property_value'

  class ActivityPropertyValue < Pike::PropertyValue

    has_many   :copies,  :class_name => 'Pike::ActivityPropertyValue', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::ActivityPropertyValue', :inverse_of => :copies

    belongs_to :activity, :class_name => 'Pike::Activity'

  end

end
