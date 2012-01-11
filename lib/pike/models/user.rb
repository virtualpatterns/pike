require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :users

    before_save :on_before_save

    has_many :identities, :class_name => 'Pike::System::Identity'

    has_many :actions_as_source, :class_name => 'Pike::System::Action', :inverse_of => :user_source
    has_many :actions_as_target, :class_name => 'Pike::System::Action', :inverse_of => :user_target

    has_many :introductions_as_source, :class_name => 'Pike::Introduction', :inverse_of => :user_source
    has_many :introductions_as_target, :class_name => 'Pike::Introduction', :inverse_of => :user_target

    has_many :friendships_as_source, :class_name => 'Pike::Friendship', :inverse_of => :user_source
    has_many :friendships_as_target, :class_name => 'Pike::Friendship', :inverse_of => :user_target

    has_many :projects, :class_name => 'Pike::Project'
    field :project_properties, :type => Array, :default => []

    has_many :activities, :class_name => 'Pike::Activity'
    field :activity_properties, :type => Array, :default => []

    has_many :tasks, :class_name => 'Pike::Task'
    field :task_properties, :type => Array, :default => []

    has_many :work, :class_name => 'Pike::Work'

    field :url, :type => String
    field :_url, :type => String

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at

    default_scope order_by([:_url, :asc])

    scope :where_url, lambda { |url| where(:_url => url.downcase) }

    def self.get_user_by_url(url, create = true)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) if create && user == nil
      return user
    end

    protected

      def on_before_save
        self._url = self.url.downcase if self.url_changed?
      end

  end

end
