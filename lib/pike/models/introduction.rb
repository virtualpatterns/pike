require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Introduction
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :introductions

    before_save :on_before_save

    belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :introductions_as_source
    belongs_to :user_target,   :class_name => 'Pike::User', :inverse_of => :introductions_as_target

    validates_presence_of :user_source
    validates_presence_of :user_target

    field :message, :type => String, :default => 'Be my friend!'
    field :_user_target_url, :type => String

    default_scope order_by([:user_target_id, :asc], [:_user_source_url, :asc])

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      introduction1 = Pike::Introduction.create_introduction!('Assert Indexes User 1', 'Assert Indexes User 2', 'Assert Indexes Introduction')

      user3 = Pike::User.get_user_by_url('Assert Indexes User 3')
      introduction2 = Pike::Introduction.create_introduction!('Assert Indexes User 1', 'Assert Indexes User 2', 'Assert Indexes Introduction')

      self.assert_index(user2.introductions_as_target.all)

    end

    def accept!
      Pike::Friendship::create!(:user_source => self.user_source, :user_target => self.user_target) unless Pike::Friendship.where_friendship(self.user_source, self.user_target).exists?
      Pike::Friendship::create!(:user_source => self.user_target, :user_target => self.user_source) unless Pike::Friendship.where_friendship(self.user_target, self.user_source).exists?
      self.destroy
    end

    def reject!
      self.destroy
    end

    def self.create_introduction!(source_url, target_url, message)
      return Pike::Introduction.create!(:user_source_id => Pike::User.get_user_by_url(source_url).id,
                                        :user_target_id => Pike::User.get_user_by_url(target_url).id,
                                        :message        => message)
    end

    protected

      def on_before_save
        self._user_target_url = self.user_target.url.downcase if self.user_target_id_changed?
      end

  end

end
