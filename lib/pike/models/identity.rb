require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'mongoid'
require 'uuid'

module Pike

  class Identity
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :identities

    belongs_to :user, :class_name => 'Pike::User'

    field :value, :type => String, :default => lambda { UUID.new.generate }
    field :expires, :type => Time, :default => lambda { Chronic.parse('next month') }

    validates_presence_of :value
    validates_presence_of :expires
    validates_uniqueness_of :value, :scope => [:deleted_at]

    default_scope where(:expires.gt => Time.now).order_by([[:created_at, :desc]])

    scope :where_value, lambda { |value| where(:value => value) }

    def self.get_identity_by_value(value)
      Pike::Identity.where_value(value).first
    end

  end

end
