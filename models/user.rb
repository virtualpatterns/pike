require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'models/task'

  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    after_create :on_after_create

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

    protected

      # Create a slack project/activity for a new user
      def on_after_create
        project = self.projects.create!(:name => 'Slack')
        activity = self.activities.create!(:name => 'Slack')
        self.tasks.create!(:project => project, :activity => activity, :flag => Pike::Task::FLAG_FIXED)
      end

  end

end
