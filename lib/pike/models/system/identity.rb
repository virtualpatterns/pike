require 'rubygems'
require 'bundler/setup'

require 'chronic'
require 'mongoid'

module Pike

  module System
    require 'pike/mixins'

    class Identity
      include Mongoid::Document
      include Mongoid::Timestamps
      extend Pike::Mixins::IndexMixin

      store_in :system_identities

      belongs_to :user, :class_name => 'Pike::User'

      field :value, :type => String, :default => lambda { Pike::System::Identity.generate_identity_value }
      field :expires, :type => Time, :default => lambda { Chronic.parse('next month') }

      validates_presence_of :value
      validates_presence_of :expires
      validates_uniqueness_of :value

      default_scope where(:expires.gt => Time.now).order_by([[:created_at, :desc]])

      scope :where_value, lambda { |value| where(:value => value) }

      index [[:value,      1],
             [:expires,    1],
             [:created_at, -1]]

      index [[:expires,    1],
             [:created_at, -1]]

      def url
        return self.user.url
      end

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

      def self.assert_indexes
        identity = Pike::System::Identity.create!(:user => Pike::User.get_user_by_url('Assert Indexes User'))
        self.assert_index(Pike::System::Identity.all)
        self.assert_index(Pike::System::Identity.where_value(identity.value))
      end

    end

  end

end
