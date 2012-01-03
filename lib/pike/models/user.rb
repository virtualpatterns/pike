require 'rubygems'
require 'bundler/setup'

require 'mongoid'
require 'uuid'

require 'ruby_app/log'

module Pike

  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :users

    has_many :identities, :class_name => 'Pike::Identity'
    has_many :projects, :class_name => 'Pike::Project'
    has_many :activities, :class_name => 'Pike::Activity'
    has_many :tasks, :class_name => 'Pike::Task'
    has_many :work, :class_name => 'Pike::Work'

    field :url, :type => String
    field :project_properties, :type => Array, :default => []

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at

    default_scope order_by([:url, :asc])

    scope :where_url, lambda { |url| where(:url => url) }

    def self.get_user_by_url(url)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) unless user
      return user
    end

  end

end
