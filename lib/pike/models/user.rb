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

    store_in :collection => :users

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

    has_many :message_states, :class_name => 'Pike::System::MessageState'

    field :uri, :type => String
    field :_uri, :type => String
    field :name, :type => String
    field :_name, :type => String

    field :is_administrator, :type => Boolean, :default => false

    validates_presence_of :uri
    validates_uniqueness_of :uri, :scope => :deleted_at

    default_scope order_by([:_name, :asc], [:_uri, :asc])

    scope :where_uri, lambda { |uri| where(:_uri => uri.downcase) }
    scope :where_name, lambda { |name| where(:_name => name ? name.downcase : nil) }
    scope :where_search, lambda { |user, value| where(:_id.ne => user.id ).and(:_name => /^#{value.downcase}/) }

    def self.assert_indexes
      user1 = Pike::User.get_user_by_uri('Assert Indexes User 1')
      user1.name = 'User, Assert Indexes 1'
      user1.save!

      user2 = Pike::User.get_user_by_uri('Assert Indexes User 2')
      user2.name = 'User, Assert Indexes 2'
      user2.save!

      user3 = Pike::User.get_user_by_uri('Assert Indexes User 3')
      user3.name = nil
      user3.save!

      self.assert_index(Pike::User.all)
      self.assert_index(Pike::User.where_uri('Assert Indexes User 1'))
      self.assert_index(Pike::User.where_name('User, Assert Indexes 1'))
      self.assert_index(Pike::User.where_name(nil))

      self.assert_index(Pike::User.where_search(user2, 'User'))

    end

    def abbreviated_uri
      self._uri =~ /([^\@]+)@.*/
      return "#{$1}@..."
    end

    def administrator?
      return self.is_administrator
    end

    def guest?
      return self.uri =~ /pike\.virtualpatterns\.com/
    end

    def get_work_duration_minutes(date)
      return ((self.work.where_date(date).sum(:duration) || 0)/60).round * 60
    end

    def refresh_message_states!
      messages = self.message_states.exists? ? Pike::System::Message.created_since(self.message_states.last.message.created_at) : Pike::System::Message.all
      messages.each do |message|
        self.message_states.create!(:message  => message,
                                    :state    => Pike::System::MessageState::TYPE_NEW)
      end
    end

    def create_identity!
      return Pike::System::Identity.create!(:source   => Pike::System::Identity::SOURCE_UNKNOWN,
                                            :user_id  => self.id)
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

    def create_friendship!(uri)
      user = Pike::User.get_user_by_uri(uri)
      Pike::Friendship::create!(:user_source_id => self.id,
                                :user_target_id => user.id) unless Pike::Friendship.where_friendship(self, user).exists?
      Pike::Friendship::create!(:user_source_id => user.id,
                                :user_target_id => self.id) unless Pike::Friendship.where_friendship(user, self).exists?
    end

    def delete_friendship!(uri)
      user = Pike::User.get_user_by_uri(uri)
      Pike::Friendship.destroy_all(:user_source_id => self.id,
                                   :user_target_id => user.id)
      Pike::Friendship.destroy_all(:user_source_id => user.id,
                                   :user_target_id => self.id)
    end

    def self.create_user!(uri, name = nil, is_administrator = false)
      user = self.get_user_by_uri(uri)
      user.name = name if name
      user.is_administrator = is_administrator if is_administrator
      user.save!
      return user
    end

    def self.get_user_by_uri(uri, create = true)
      user = Pike::User.where_uri(uri).first
      user = Pike::User.create!(:uri => uri) if create && user == nil
      return user
    end

    def self.get_random_user
      uri = "#{SecureRandom.hex(Pike::User.configuration._length)}@pike.virtualpatterns.com"
      while Pike::User.where_uri(uri).first
        uri = "#{SecureRandom.hex(Pike::User.configuration._length)}@pike.virtualpatterns.com"
      end
      return Pike::User.create!(:uri => uri)
    end

    protected

      def on_before_save
        self._uri = self.uri.downcase if self.uri_changed?
        self._name = ( self.name ? self.name.downcase : nil ) if self.name_changed?
      end

  end

end
