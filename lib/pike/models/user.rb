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
    field :is_guest, :type => Boolean, :default => false

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at

    scope :where_url, lambda { |url| where(:url => url) }
    scope :where_is_guest, lambda { where(:is_guest => true).order_by([[:created_at, :asc]]) }

    def self.get_user_by_url(url)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) unless user
      return user
    end

    def self.exists_guest_user?
      Pike::User.where_is_guest.count > 0
    end

    def self.create_guest_user!
      guest = Pike::User.get_user_by_url("Guest #{UUID.new.generate}")
      guest.is_guest = true
      guest.save!
      RubyApp::Log.debug("#{self}##{__method__} guest.url=#{guest.url.inspect}")
      guest
    end

  end

end
