require 'rubygems'
require 'bundler/setup'

require 'mongoid'
require 'uuid'

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
    field :identity, :type => String

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at
    validates_uniqueness_of :identity, :scope => :deleted_at

    scope :where_url, lambda { |url| where(:url => url) }
    scope :where_identity, lambda { |identity| where(:identity => identity) }

    def generate_identity
      self.identity = UUID.new.generate.upcase
      self.save!
      self.identity
    end

    def self.get_user_by_url(url)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) unless user
      return user
    end

    def self.get_user_by_identity(identity)
      Pike::User.where_identity(identity).first
    end

  end

end
