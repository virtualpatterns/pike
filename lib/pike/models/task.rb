require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike
  require 'pike/mixins'

  class Task
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :tasks

    before_save :on_before_save
    before_destroy :on_before_destroy

    FLAG_LIKED      = 0
    FLAG_NORMAL     = 1
    FLAG_COMPLETED  = 2
    FLAG_NAMES      = { Pike::Task::FLAG_LIKED      => 'Liked',
                        Pike::Task::FLAG_NORMAL     => 'Other',
                        Pike::Task::FLAG_COMPLETED  => 'Completed' }

    belongs_to :user, :class_name => 'Pike::User'
    belongs_to :project, :class_name => 'Pike::Project'
    belongs_to :activity, :class_name => 'Pike::Activity'

    has_many :work, :class_name => 'Pike::Work'

    validates_presence_of :user
    validates_presence_of :project
    validates_presence_of :activity
    validates_uniqueness_of :activity_id, :scope => [:project_id]

    field :flag, :type => Integer, :default => Pike::Task::FLAG_NORMAL
    field :_project_name, :type => String
    field :_activity_name, :type => String

    validates_presence_of :flag

    default_scope order_by([[:flag, :asc], [:_project_name, :asc],[:_activity_name, :asc]])

    scope :where_project, lambda { |project| where(:project_id => project.id) }
    scope :where_activity, lambda { |activity| where(:activity_id => activity.id) }

    index [[:user_id,        1],
           [:flag,           1],
           [:project_id,     1],
           [:_project_name,  1],
           [:activity_id,    1],
           [:_activity_name, 1]]

    def self.assert_indexes
      user = Pike::User.get_user_by_url('Assert Indexes User')
      project = user.create_project!('Assert Indexes Project')
      activity = user.create_activity!('Assert Indexes Activity')
      task = user.create_task!('Assert Indexes Project', 'Assert Indexes Activity')

      self.assert_index(user.tasks.all)
      self.assert_index(user.tasks.where_project(project))
      self.assert_index(user.tasks.where_activity(activity))

    end

    protected

      def on_before_save
        self._project_name = self.project.name.downcase if self.project_id_changed?
        self._activity_name = self.activity.name.downcase if self.activity_id_changed?
      end

      def on_before_destroy
        RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} Pike::Work.destroy_all(:task_id => #{self.id})")
        Pike::Work.destroy_all(:task_id => self.id)
      end

  end

end
