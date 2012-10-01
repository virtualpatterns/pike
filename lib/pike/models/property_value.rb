require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class PropertyValue
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :property_values

    belongs_to :property, :class_name => 'Pike::Property'

    field :value, :type => String

    scope :where_property, lambda { |property| where(:property_id => property.id) }

  end

end
