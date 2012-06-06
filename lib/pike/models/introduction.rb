require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Introduction
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :introductions

    belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :introductions_as_source
    belongs_to :user_target,   :class_name => 'Pike::User', :inverse_of => :introductions_as_target

    validates_presence_of :user_source
    validates_presence_of :user_target

    field :message, :type => String, :default => 'Be my friend!'

    def accept!
      Pike::Friendship::create!(:user_source => self.user_source, :user_target => self.user_target) unless Pike::Friendship.where_friendship(self.user_source, self.user_target).exists?
      Pike::Friendship::create!(:user_source => self.user_target, :user_target => self.user_source) unless Pike::Friendship.where_friendship(self.user_target, self.user_source).exists?
      self.destroy
    end

    def reject!
      self.destroy
    end

    def self.create_introduction!(user_source_url, user_target_url, message)
      return Pike::Introduction.create!(:user_source_id => Pike::User.get_user_by_url(user_source_url).id,
                                        :user_target_id => Pike::User.get_user_by_url(user_target_url).id,
                                        :message        => message)
    end

  end

end
