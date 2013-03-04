require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Activity
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :collection => :activities

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    has_many   :copies,  :class_name => 'Pike::Activity', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Activity', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    has_many :values, :class_name => 'Pike::ActivityPropertyValue', :inverse_of => :activity

    field :name, :type => String
    field :_name, :type => String
    field :is_shared, :type => Boolean, :default => false

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :copy_of_id]

    default_scope order_by([:user_id, :asc], [:_name, :asc])

    scope :where_name, lambda { |name| where(:_name => name ? name.downcase : nil) }
    scope :where_shared, where(:is_shared => true)

    scope :where_copy_of, lambda { |project| where(:copy_of_id => project ? project.id : nil) }
    scope :where_not_copy, where(:copy_of_id => nil)

    def self.assert_indexes
      user1 = Pike::User.get_user_by_uri('Assert Indexes User 1')
      activity1 = user1.create_activity!('Assert Indexes Activity 1', true)
      activity2 = user1.create_activity!('Assert Indexes Activity 2', false)

      user2 = Pike::User.get_user_by_uri('Assert Indexes User 2')
      activity3 = user2.create_activity!('Assert Indexes Activity 3', false)
      user1.create_friendship!('Assert Indexes User 2')

      user3 = Pike::User.get_user_by_uri('Assert Indexes User 3')
      user1.create_friendship!('Assert Indexes User 3')

      Pike::System::Action.execute_all!

      self.assert_index(Pike::Activity.all)
      self.assert_index(user1.activities.all)
      self.assert_index(user1.activities.where_name('Assert Indexes Activity 1'))
      self.assert_index(user1.activities.where_shared)
      self.assert_index(user2.activities.where_copy_of(activity1))
      self.assert_index(user2.activities.where_not_copy)
      self.assert_index(activity1.copies.all)

    end

    def copy?
      return self.copy_of
    end

    def shared?
      return self.is_shared
    end

    def exists_tasks?
      return self.tasks.exists?
    end

    def create_value!(name, value)
      property = self.user.create_property!(Pike::Property::TYPE_ACTIVITY, name)
      _value = self.values.where_property(property).first || self.values.create!(:property => property)
      _value.value = value
      _value.save!
      return _value
    end

    def self.create_activity!(uri, name, is_shared = false, properties = {})
      user = Pike::User.get_user_by_uri(uri)
      return user.create_activity!(name, is_shared, properties)
    end

    def self.update_activity!(uri, name, to_name = nil, to_is_shared = nil, to_properties = {})
      Pike::User.get_user_by_uri(uri).update_activity!(name, to_name, to_is_shared, to_properties)
    end

    def self.delete_activity!(uri, name)
      Pike::User.get_user_by_uri(uri).delete_activity!(name)
    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_save
        if self.name_changed?
          self.tasks.all.each do |task|
            task.set(:_activity_name, self.name.downcase)
          end
        end
      end

      def on_before_destroy
        raise 'The selected activity cannot be deleted.  The activity is assigned to a task.' if exists_tasks?
        Pike::ActivityPropertyValue.destroy_all(:activity_id => self.id)
      end

  end

end
