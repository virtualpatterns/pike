require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'mongoid'

module Pike

  module System

    class Identity
      include Mongoid::Document
      include Mongoid::Timestamps

      store_in :system_identities

      belongs_to :user, :class_name => 'Pike::User'

      field :value, :type => String, :default => lambda { Pike::System::Identity.generate_identity_value }
      field :expires, :type => Time, :default => lambda { Chronic.parse('next month') }

      validates_presence_of :value
      validates_presence_of :expires
      validates_uniqueness_of :value

      default_scope where(:expires.gt => Time.now).order_by([[:created_at, :desc]])

      scope :where_value, lambda { |value| where(:value => value) }

      def self.get_identity_by_value(value)
        Pike::System::Identity.where_value(value).first
      end

      def self.generate_identity_value
        value = SecureRandom.hex
        while Pike::System::Identity.get_identity_by_value(value)
          value = SecureRandom.hex
        end
        return value
      end

    end

  end

end
