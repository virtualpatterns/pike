require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Friendship
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :friendships

    belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :friendships_as_source
    belongs_to :user_target, :class_name => 'Pike::User', :inverse_of => :friendships_as_target

    validates_presence_of :user_source
    validates_presence_of :user_target
    validates_uniqueness_of :user_source_id, :scope => [:user_target_id, :deleted_at]

    scope :where_friendship, lambda { |user_source, user_target| where(:user_source_id => user_source.id).where(:user_target_id => user_target.id) }
    scope :where_user_target, lambda { |user_target| where(:user_target_id => user_target.id) }

  end

end
