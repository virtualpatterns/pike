require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Task
    include Mongoid::Document
    include Mongoid::Timestamps

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
    scope :where_flag, lambda { |flag| where(:flag => flag) }
    scope :where_not_flag, lambda { |flag| where(:flag.ne => flag) }

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
