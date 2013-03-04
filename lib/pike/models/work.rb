require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app'

module Pike
  require 'pike/mixins'

  class Work
    include Mongoid::Document
    include Mongoid::Timestamps
    extend Pike::Mixins::IndexMixin

    store_in :collection => :work

    before_save :on_before_save

    belongs_to :user, :class_name => 'Pike::User'
    belongs_to :task, :class_name => 'Pike::Task'

    validates_presence_of :user
    validates_presence_of :task

    field :date, :type => Date
    field :duration, :type => Integer, :default => 0
    field :note, :type => String
    field :is_started, :type => Boolean, :default => false
    field :started_at, :type => Time
    field :updated_at, :type => Time
    field :_project_name, :type => String
    field :_activity_name, :type => String

    validates_presence_of :date

    validates_uniqueness_of :task_id, :scope => [:date]

    default_scope order_by([[:date, :asc], [:_project_name, :asc],[:_activity_name, :asc]])

    scope :where_task, lambda { |task| where(:task_id => task.id ) }
    scope :where_date, lambda { |date| where(:date => date) }
    scope :where_not_date, lambda { |date| where(:date.ne => date) }
    scope :where_week, lambda { |date| where(:date.gte => date.week_start).and(:date.lte => date.week_end) }
    scope :where_started, where(:is_started => true)

    def self.assert_indexes
      user = Pike::User.get_user_by_uri('Assert Indexes User')
      task1 = user.create_task!('Assert Indexes Project 1', 'Assert Indexes Activity 1')
      work1 = user.create_work!('Assert Indexes Project 1', 'Assert Indexes Activity 1', Date.today, 1)
      work1.start!

      task2 = user.create_task!('Assert Indexes Project 2', 'Assert Indexes Activity 2')
      work2 = user.create_work!('Assert Indexes Project 2', 'Assert Indexes Activity 2', Date.today - 20, 2)

      work3 = user.create_work!('Assert Indexes Project 1', 'Assert Indexes Activity 1', Date.today - 30, 1)

      self.assert_index(user.work.where_task(task1))
      self.assert_index(user.work.where_date(Date.today))
      self.assert_index(user.work.where_not_date(Date.today))
      self.assert_index(user.work.where_week(Date.today))
      self.assert_index(user.work.where_started)

      self.assert_index(task1.work.where_date(Date.today))

    end

    def duration_minutes
      return (self.duration/60).round * 60
    end

    def started?
      return self.is_started
    end

    def start!
      unless self.started?
        self.is_started = true
        self.started_at = Time.now
        self.updated_at = self.started_at
        self.save!
      end
    end

    def finish!
      if self.started?
        self.duration = (self.duration || 0) + ( Time.now - self.updated_at ).to_i
        self.updated_at = nil
        self.started_at = nil
        self.is_started = false
        self.save!
      end
    end

    def update_duration!
      if self.started?
        self.duration = (self.duration || 0) + ( Time.now - self.updated_at ).to_i
        self.updated_at = Time.now
        self.save!
      end
    end

    protected

      def on_before_save
        if self.task_id_changed?
          self._project_name = self.task.project.name.downcase
          self._activity_name = self.task.activity.name.downcase
        end
      end

  end

end
