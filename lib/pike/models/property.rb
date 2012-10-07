require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Property
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :properties

    before_save :on_before_save
    before_destroy :on_after_destroy

    TYPE_NONE     = 0
    TYPE_PROJECT  = 1
    TYPE_ACTIVITY = 2
    TYPE_TASK     = 3
    TYPE_NAMES    = { Pike::Property::TYPE_NONE     => 'None',
                      Pike::Property::TYPE_PROJECT  => 'Project',
                      Pike::Property::TYPE_ACTIVITY => 'Activity',
                      Pike::Property::TYPE_TASK     => 'Task' }

    has_many   :copies,  :class_name => 'Pike::Property', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Property', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'

    field :type, :type => Integer, :default => Pike::Property::TYPE_NONE
    field :name, :type => String
    field :_name, :type => String

    validates_presence_of :type
    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :type, :copy_of_id]

    default_scope order_by([:user_id, :asc], [:type, :asc], [:_name, :asc])

    scope :where_project, where(:type => Pike::Property::TYPE_PROJECT)
    scope :where_activity, where(:type => Pike::Property::TYPE_ACTIVITY)
    scope :where_task, where(:type => Pike::Property::TYPE_TASK)
    scope :where_type, lambda { |type| where(:type => type) }
    scope :where_name, lambda { |name| where(:_name => name ? name.downcase : nil) }
    scope :where_copy_of, lambda { |property| where(:copy_of_id => property ? property.id : nil) }
    scope :where_not_copy, where(:copy_of_id => nil)

    def copy?
      return self.copy_of
    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_destroy
        # TODO ... index ?
        Pike::ProjectPropertyValue.destroy_all(:property_id => self.id)
        # TODO ... index ?
        Pike::ActivityPropertyValue.destroy_all(:property_id => self.id)
        # TODO ... index ?
        Pike::TaskPropertyValue.destroy_all(:property_id => self.id)
      end

  end

end
