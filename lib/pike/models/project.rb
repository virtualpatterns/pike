require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Project
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :projects

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    has_many   :copies,  :class_name => 'Pike::Project', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Project', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    has_many :values, :class_name => 'Pike::ProjectPropertyValue', :inverse_of => :project

    field :name, :type => String
    field :_name, :type => String
    field :is_shared, :type => Boolean, :default => false

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :copy_of_id]

    default_scope order_by([:user_id, :asc], [:_name, :asc])

    scope :where_name, lambda { |name| where(:_name => name ? name.downcase : nil) }
    scope :where_shared, where(:is_shared => true)
    scope :where_copy_of, lambda { |project| where(:copy_of_id => project ? project.id : nil) }

    index [[:user_id,    1],
           [:_name,      1],
           [:is_shared,  1],
           [:copy_of_id, 1]]

    def shared?
      self.is_shared
    end

    def exists_tasks?
      self.tasks.exists?
    end

    def create_value!(property_name, value)
      property = self.user.create_property!(Pike::Property::TYPE_PROJECT, property_name)
      _value = self.values.where_property(property).first || self.values.create!(:property => property)
      _value.value = value
      _value.save!
    end

    def self.create_shared_project!(user_source_url, user_target_url, project_name, properties = {})
      user_source = Pike::User.get_user_by_url(user_source_url)
      user_source.create_friendship!(user_target_url)
      return user_source.create_project!(project_name, true, properties)
    end

    def self.update_shared_project!(user_source_url, project_name_from, project_name_to)
      Pike::User.get_user_by_url(user_source_url).projects.where_name(project_name_from).each do |project|
        project.name = project_name_to
        project.save!
      end
    end

    def self.delete_shared_project!(user_source_url, project_name)
      Pike::User.get_user_by_url(user_source_url).projects.where_name(project_name).each do |project|
        project.destroy
      end
    end

    def self.unshare_project!(user_source_url, project_name)
      Pike::User.get_user_by_url(user_source_url).projects.where_name(project_name).each do |project|
        project.is_shared = false
        project.save!
      end
    end

    def self.assert_indexes
      user1 = Pike::User.get_user_by_url('Assert Indexes User 1')
      project1 = user1.create_project!('Assert Indexes Project 1', true)
      user2 = Pike::User.get_user_by_url('Assert Indexes User 2')
      friendship = user1.create_friendship!('Assert Indexes User 2')

      Pike::System::Action.execute_all!

      self.assert_index(Pike::Project.all)
      self.assert_index(user1.projects.all)
      self.assert_index(user1.projects.where_name('Assert Indexes Project 1'))
      self.assert_index(user1.projects.where_shared)
      self.assert_index(user2.projects.where_copy_of(project1))

    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_save
        if self.name_changed?
          self.tasks.all.each do |task|
            task.set(:_project_name, self.name.downcase)
          end
        end
      end

      def on_before_destroy
        raise 'The selected project cannot be deleted.  The project is assigned to a task.' if exists_tasks?
        # TODO ... index ?
        Pike::ProjectPropertyValue.destroy_all(:project_id => self.id)
      end

  end

end
