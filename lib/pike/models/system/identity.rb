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

      attr_accessor :token

      store_in :system_identities

      SOURCE_UNKNOWN  = 0
      SOURCE_GITHUB   = 1
      SOURCE_GOOGLE   = 2
      SOURCE_FACEBOOK = 3
      SOURCE_NAMES    = { Pike::System::Identity::SOURCE_UNKNOWN  => 'Unknown',
                          Pike::System::Identity::SOURCE_GITHUB   => 'GitHub',
                          Pike::System::Identity::SOURCE_GOOGLE   => 'Google',
                          Pike::System::Identity::SOURCE_FACEBOOK => 'Facebook' }

      belongs_to :user, :class_name => 'Pike::User'

      field :source, :type => Integer
      field :value, :type => String, :default => lambda { Pike::System::Identity.generate_identity_value }
      field :expires_at, :type => Time, :default => lambda { Chronic.parse('next month') }

      validates_presence_of :source
      validates_presence_of :value
      validates_presence_of :expires_at
      validates_uniqueness_of :value

      default_scope where(:expires_at.gt => Time.now).order_by([[:created_at, :desc]])

      scope :where_value, lambda { |value| where(:value => value) }

      index [[:expires_at,  1],
             [:created_at, -1]]

      index [[:value,       1],
             [:expires_at,  1],
             [:created_at, -1]]

      def self.assert_indexes
        user = Pike::User.get_user_by_url('Assert Indexes User')
        identity = user.create_identity!
        self.assert_index(Pike::System::Identity.all)
        self.assert_index(Pike::System::Identity.where_value(identity.value))
      end

      def url
        return self.user.url
      end

      def source?(source)
        return self.source == source
      end

      def import_tasks!
        if self.token.is_a?(::OAuth2::AccessToken)
          repositories = JSON.parse(self.token.get('/user/repos?type=all').body)
          repositories.each do |repository|
            self.user.projects.create!(:name       => repository['full_name'],
                                       :is_shared  => true) unless self.user.projects.where_name(repository['full_name']).where_not_copy.exists?
          end
          unless self.user.activities.all.exists?
            ['Design',
             'Develop',
             'Test'].each do |activity|
              self.user.activities.create!(:name => activity)
            end
          end
          self.user.projects.all.each do |project|
            self.user.activities.all.each do |activity|
              self.user.tasks.create!(:project_id => project.id,
                                      :activity_id => activity.id,
                                      :flag => Pike::Task::FLAG_LIKED) unless self.user.tasks.where_project(project).where_activity(activity).exists?
            end
          end
        end
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

    end

  end

end
