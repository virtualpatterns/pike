require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Property
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

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

    index [[:user_id,     1],
           [:type,        1],
           [:_name,       1],
           [:copy_of_id,  1]]

    index [[:copy_of_id,  1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      project_property1 = user1.create_property!(Pike::Property::TYPE_PROJECT, 'Assert Indexes Project Property 1')
      activity_property1 = user1.create_property!(Pike::Property::TYPE_ACTIVITY, 'Assert Indexes Activity Property 1')

      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      project_property2 = user2.create_property!(Pike::Property::TYPE_PROJECT, 'Assert Indexes Project Property 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      user3 = Pike::User.get_user_by_url('Assert Indexes User 3')
      friendship2 = user1.create_friendship!('Assert Indexes User 3')

      Pike::System::Action.execute_all!

      self.assert_index(user1.properties.where_type(Pike::Property::TYPE_PROJECT))
      self.assert_index(user1.properties.where_name('Assert Indexes Project Property 1'))
      # self.assert_index(user2.properties.where_copy_of(project_property1)) # TODO ... why is the wrong index being used?
      self.assert_index(user1.properties.where_not_copy)
      self.assert_index(project_property1.copies.all)

    end

    def copy?
      return self.copy_of
    end

    def self.create_property!(url, type, name)
      Pike::User.get_user_by_url(url).create_property!(type, name)
    end

    def self.update_property!(url, type, name, to_name)
      Pike::User.get_user_by_url(url).update_property!(type, name, to_name)
    end

    def self.delete_property!(url, type, name)
      Pike::User.get_user_by_url(url).delete_property!(type, name)
    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_destroy
        Pike::ProjectPropertyValue.destroy_all(:property_id => self.id)
        Pike::ActivityPropertyValue.destroy_all(:property_id => self.id)
        Pike::TaskPropertyValue.destroy_all(:property_id => self.id)
      end

  end

end
