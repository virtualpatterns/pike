require 'rubygems'
require 'bundler/setup'

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

    validates_presence_of :value
    validates_uniqueness_of :value, :scope => [:deleted_at]

    default_scope order_by([[:created_at, :desc]])

    scope :where_value, lambda { |value| where(:value => value) }

    def self.get_identity_by_value(value)
      Pike::Identity.where_value(value).first
    end

  end

end
