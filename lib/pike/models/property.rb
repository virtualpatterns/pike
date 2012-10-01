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

    has_many :synchronize_actions, :class_name => 'Pike::System::Actions::PropertySynchronizeAction'

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

    scope :where_type_and_name, lambda { |type, name| where(:type => type).and(:_name => name.downcase) }
    scope :where_copy_of, lambda { |project| where(:copy_of_id => project.id) }

    index [[:user_id,    1],
           [:type,       1],
           [:_name,      1],
           [:copy_of_id, 1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      property1 = user1.create_property!(Pike::Property::TYPE_NONE, 'Assert Indexes Property 1')
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      self.assert_index(user1.properties.where_type_and_name(Pike::Property::TYPE_NONE, 'Assert Indexes Property 1'))
      self.assert_index(user2.properties.where_copy_of(property1))

    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_destroy
        self.property_values.each do |property_value|
          property_value.destroy
        end
      end

  end

end
