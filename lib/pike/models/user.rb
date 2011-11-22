require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/models/task'

  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :users

    has_many :projects, :class_name => 'Pike::Project'
    has_many :activities, :class_name => 'Pike::Activity'
    has_many :tasks, :class_name => 'Pike::Task'
    has_many :work, :class_name => 'Pike::Work'

    field :url, :type => String

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at

    scope :where_url, lambda { |url| where(:url => url) }

    def self.get_user(url)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) unless user
      return user
    end

  end

end
