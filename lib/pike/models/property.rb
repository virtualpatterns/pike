require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Property
    # Overview ...
    # user has one or more properties
    # each property has a type and a name
    # force unique on name for a given type for a user
    # when a user1 becomes friends with a user2 all the properties of user1 are copied to user2
    # a user2 can create projects/activities/

    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :properties

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    TYPE_PROJECT  = 0
    TYPE_ACTIVITY = 1
    TYPE_TASK     = 2
    TYPE_NAMES    = { Pike::Property::TYPE_PROJECT  => 'Liked',
                      Pike::Property::TYPE_ACTIVITY => 'Other',
                      Pike::Property::TYPE_TASK     => 'Completed' }

    has_many :synchronize_actions, :class_name => 'Pike::System::Actions::PropertySynchronizeAction'

    has_many   :copies,  :class_name => 'Pike::Property', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Property', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'
    has_many :property_values, :class_name => 'Pike::PropertyValue'

    field :name, :type => String
    field :_name, :type => String
    field :type, :type => Integer

    validates_presence_of :name
    validates_presence_of :type
    validates_uniqueness_of :name, :scope => [:user_id, :type, :copy_of_id]

    default_scope order_by([:user_id, :asc], [:type, asc], [:_name, :asc])

    scope :where_type, lambda { |type| where(:type => type) }
    scope :where_name, lambda { |name| where(:_name => name.downcase) }
    scope :where_copy_of, lambda { |project| where(:copy_of_id => project.id) }

    index [[:user_id,    1],
           [:_name,      1],
           [:type,  1],
           [:copy_of_id, 1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      project_property1 = user1.create_property!(Pike::Property::TYPE_PROJECT, 'Assert Indexes Project Property 1')
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      self.assert_index(Pike::Property.all)
      self.assert_index(user1.properties.all)
      self.assert_index(user1.properties.where_type(Pike::Property::TYPE_PROJECT))
      self.assert_index(user1.properties.where_name('Assert Indexes Property 1'))
      self.assert_index(user2.properties.where_copy_of(project_property1))

    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_save
        if self.name_changed?
          self.tasks.all.each do |task|
            task.set(:_project_name, self.name.downcase)
          end
        end
      end

      def on_before_destroy
        raise 'The selected project cannot be deleted.  The project is assigned to a task.' if exists_tasks?
      end

  end

end
