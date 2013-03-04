require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Friendship
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :collection => :friendships

    before_save :on_before_save

    belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :friendships_as_source
    belongs_to :user_target, :class_name => 'Pike::User', :inverse_of => :friendships_as_target

    validates_presence_of :user_source
    validates_presence_of :user_target
    validates_uniqueness_of :user_source_id, :scope => [:user_target_id]

    field :_user_target_uri, :type => String

    default_scope order_by([:user_source_id, :asc], [:_user_target_uri, :asc])

    scope :where_friendship, lambda { |user_source, user_target| where(:user_source_id => user_source.id).where(:user_target_id => user_target.id) }
    scope :where_user_target, lambda { |user_target| where(:user_target_id => user_target.id) }

    def self.assert_indexes
      user1 = Pike::User.get_user_by_uri('Assert Indexes User 1')
      user2 = Pike::User.get_user_by_uri('Assert Indexes User 2')
      user1.create_friendship!('Assert Indexes User 2')

      user3 = Pike::User.get_user_by_uri('Assert Indexes User 3')
      user1.create_friendship!('Assert Indexes User 3')
      user2.create_friendship!('Assert Indexes User 3')

      self.assert_index(Pike::Friendship.where_friendship(user1, user2))
      self.assert_index(user1.friendships_as_source.all)
      self.assert_index(user1.friendships_as_source.where_user_target(user2))

    end

    protected

      def on_before_save
        self._user_target_uri = self.user_target.uri.downcase if self.user_target_id_changed?
      end

  end

end
