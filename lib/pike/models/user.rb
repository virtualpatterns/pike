require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app/mixins'

module Pike
  require 'pike/mixins'

  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    extend RubyApp::Mixins::ConfigurationMixin
    extend Pike::Mixins::IndexMixin

    store_in :users

    before_save :on_before_save

    has_many :identities, :class_name => 'Pike::System::Identity'

    has_many :introductions_as_source, :class_name => 'Pike::Introduction', :inverse_of => :user_source
    has_many :introductions_as_target, :class_name => 'Pike::Introduction', :inverse_of => :user_target

    has_many :friendships_as_source, :class_name => 'Pike::Friendship', :inverse_of => :user_source
    has_many :friendships_as_target, :class_name => 'Pike::Friendship', :inverse_of => :user_target

    has_many :properties, :class_name => 'Pike::Property'

    has_many :projects, :class_name => 'Pike::Project'
    has_many :activities, :class_name => 'Pike::Activity'
    has_many :tasks, :class_name => 'Pike::Task'

    has_many :work, :class_name => 'Pike::Work'

    field :url, :type => String
    field :_url, :type => String

    field :is_administrator, :type => Boolean, :default => false

    validates_presence_of :url
    validates_uniqueness_of :url, :scope => :deleted_at

    default_scope order_by([:_url, :asc])

    scope :where_url, lambda { |url| where(:_url => url.downcase) }

    index [[:_url, 1]], { :unique => true }

    def self.assert_indexes
      user = Pike::User.get_user_by_url('Assert Indexes User')
      self.assert_index(Pike::User.all)
      self.assert_index(Pike::User.where_url('Assert Indexes User'))
    end

    def administrator?
      self.is_administrator
    end

    def guest?
      self.url =~ /pike\.virtualpatterns\.com/
    end

    def get_work_duration_minutes(date)
      ((self.work.where_date(date).sum(:duration) || 0)/60).round * 60
    end

    def create_identity!
      Pike::System::Identity.create!(:user_id => self.id)
    end

    def create_property!(type, name)
      return self.properties.where_type(type).where_name(name).where_not_copy.first || self.properties.create!(:type => type,
                                                                                                               :name => name)
    end

    def update_property!(type, name, to_name = nil)
      self.properties.where_type(type).where_name(name).where_not_copy.each do |property|
        property.name = to_name unless to_name == nil
        property.save!
      end
    end

    def delete_property!(type, name)
      self.properties.where_type(type).where_name(name).where_not_copy.each do |property|
        property.destroy
      end
    end

    def create_project!(project_name, is_shared = false, properties = {})
      project = self.projects.where_name(project_name).where_not_copy.first || self.projects.create!(:name       => project_name,
                                                                                                     :is_shared  => is_shared)
      unless properties.empty?
        properties.each do |property_name, value|
          project.create_value!(property_name, value)
        end
      end
      return project
    end

    def update_project!(project_name, to_project_name = nil, to_is_shared = nil, to_properties = {})
      self.projects.where_name(project_name).where_not_copy.each do |project|
        project.name = to_project_name unless to_project_name == nil
        RubyApp::Log.debug("project.name=#{project.name.inspect} to_is_shared=#{to_is_shared.inspect}")
        project.is_shared = to_is_shared unless to_is_shared == nil
        project.save!
        unless to_properties.empty?
          properties.each do |property_name, value|
            project.create_value!(property_name, value)
          end
        end
      end
    end

    def get_project_property(project_name, property_name)
      value = self.create_project!(project_name).values.where_property(self.create_property!(Pike::Property::TYPE_PROJECT, property_name)).first
      return value ? value.value : nil
    end

    def delete_project!(name)
      self.projects.where_name(name).where_not_copy.each do |project|
        project.destroy
      end
    end

    def create_activity!(activity_name, is_shared = false, properties = {})
      activity = self.activities.where_name(activity_name).where_not_copy.first || self.activities.create!(:name       => activity_name,
                                                                                                           :is_shared  => is_shared)
      unless properties.empty?
        properties.each do |property_name, value|
          activity.create_value!(property_name, value)
        end
      end
      return activity
    end

    def update_activity!(activity_name, to_activity_name = nil, to_is_shared = nil, to_properties = {})
      self.activities.where_name(activity_name).where_not_copy.each do |activity|
        activity.name = to_activity_name unless to_activity_name == nil
        activity.is_shared = to_is_shared unless to_is_shared == nil
        activity.save!
        unless to_properties.empty?
          properties.each do |property_name, value|
            activity.create_value!(property_name, value)
          end
        end
      end
    end

    def get_activity_property(activity_name, property_name)
      value = self.create_activity!(activity_name).values.where_property(self.create_property!(Pike::Property::TYPE_ACTIVITY, property_name)).first
      return value ? value.value : nil
    end

    def delete_activity!(name)
      self.activities.where_name(name).where_not_copy.each do |activity|
        activity.destroy
      end
    end

    def create_task!(project_name, activity_name, flag = Pike::Task::FLAG_NORMAL, properties = {})
      project = self.create_project!(project_name)
      activity = self.create_activity!(activity_name)
      task = self.tasks.where_project(project).where_activity(activity).first || self.tasks.create!(:project_id  => project.id,
                                                                                                    :activity_id => activity.id,
                                                                                                    :flag        => flag)
      unless properties.empty?
        properties.each do |property_name, value|
          task.create_value!(property_name, value)
        end
      end
      return task
    end

    def get_task_property(project_name, activity_name, property_name)
      value = self.create_task!(project_name, activity_name).values.where_property(self.create_property!(Pike::Property::TYPE_TASK, property_name)).first
      return value ? value.value : nil
    end

    def create_work!(project_name, activity_name, date, duration, note = nil)
      task = self.create_task!(project_name, activity_name)
      work = self.work.where_task(task).where_date(date).first || self.work.create!(:task_id   => task.id,
                                                                                    :date      => date)
      work.duration = duration
      work.note = note
      work.save!
      return work
    end

    def create_friendship!(url)
      user = Pike::User.get_user_by_url(url)
      Pike::Friendship::create!(:user_source_id => self.id,
                                :user_target_id => user.id) unless Pike::Friendship.where_friendship(self, user).exists?
      Pike::Friendship::create!(:user_source_id => user.id,
                                :user_target_id => self.id) unless Pike::Friendship.where_friendship(user, self).exists?
    end

    def self.create_user!(url)
      return self.get_user_by_url(url)
    end

    def self.get_user_by_url(url, create = true)
      user = Pike::User.where_url(url).first
      user = Pike::User.create!(:url => url) if create && user == nil
      return user
    end

    def self.get_random_user
      url = "#{SecureRandom.hex(Pike::User.configuration._length)}@pike.virtualpatterns.com"
      while Pike::User.where_url(url).first
        url = "#{SecureRandom.hex(Pike::User.configuration._length)}@pike.virtualpatterns.com"
      end
      return Pike::User.create!(:url => url)
    end

    protected

      def on_before_save
        self._url = self.url.downcase if self.url_changed?
      end

  end

end
