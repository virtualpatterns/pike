require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Friendship
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :friendships

    before_save :on_before_save

    belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :friendships_as_source
    belongs_to :user_target, :class_name => 'Pike::User', :inverse_of => :friendships_as_target

    validates_presence_of :user_source
    validates_presence_of :user_target
    validates_uniqueness_of :user_source_id, :scope => [:user_target_id]

    field :_user_target_url, :type => String

    default_scope order_by([:user_source_id, :asc], [:_user_target_url, :asc])

    scope :where_friendship, lambda { |user_source, user_target| where(:user_source_id => user_source.id).where(:user_target_id => user_target.id) }
    scope :where_user_target, lambda { |user_target| where(:user_target_id => user_target.id) }

    index [[:user_source_id,   1],
           [:user_target_id,   1],
           [:_user_target_url, 1]]

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      self.assert_index(Pike::Friendship.where_friendship(user1, user2))
      self.assert_index(user1.friendships_as_source.all)
      self.assert_index(user1.friendships_as_source.where_user_target(user2))

    end

    protected

      def on_before_save
        self._user_target_url = self.user_target.url.downcase if self.user_target_id_changed?
      end

  end

end
