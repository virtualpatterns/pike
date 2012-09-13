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

    store_in :work

    before_save :on_before_save
    before_destroy :on_before_destroy

    belongs_to :user, :class_name => 'Pike::User'
    belongs_to :task, :class_name => 'Pike::Task'

    validates_presence_of :user
    validates_presence_of :task

    field :date, :type => Date
    field :duration, :type => Integer, :default => 0
    field :note, :type => String
    field :started, :type => Time
    field :updated, :type => Time
    field :_project_name, :type => String
    field :_activity_name, :type => String

    validates_presence_of :date

    validates_uniqueness_of :task_id, :scope => [:date]

    default_scope order_by([[:date, :asc], [:_project_name, :asc],[:_activity_name, :asc]])

    scope :where_task, lambda { |task| where(:task_id => task.id ) }
    scope :where_date, lambda { |date| where(:date => date) }
    scope :where_not_date, lambda { |date| where(:date.ne => date) }
    scope :where_week, lambda { |date| where(:date.gte => date.week_start).and(:date.lte => date.week_end) }
    scope :where_started, where(:started.ne => nil)

    index [[:user_id,        1],
           [:task_id,        1],
           [:date,           1],
           [:_project_name,  1],
           [:_activity_name, 1],
           [:started,        1]]

    index [[:task_id,        1],
           [:date,           1],
           [:_project_name,  1],
           [:_activity_name, 1]]

    def duration_minutes
      return (self.duration/60).round * 60
    end

    def started?
      self.started
    end

    def start!
      unless self.started?
        self.started = Time.now
        self.updated = self.started
        self.save!
      end
    end

    def finish!
      if self.started?
        self.duration = (self.duration || 0) + ( Time.now - self.updated ).to_i
        self.started = nil
        self.updated = nil
        self.save!
      end
    end

    def update_duration!
      if self.started?
        self.duration = (self.duration || 0) + ( Time.now - self.updated ).to_i
        self.updated = Time.now
        self.save!
      end
    end

    def self.assert_indexes
      user = Pike::User.get_user_by_url('Assert Indexes User')
      task = user.create_task!('Assert Indexes Project', 'Assert Indexes Activity')
      work = user.create_work!('Assert Indexes Project', 'Assert Indexes Activity', Date.today, 123)
      work.start!

      self.assert_index(user.work.where_task(task))
      self.assert_index(user.work.where_date(Date.today))
      self.assert_index(user.work.where_not_date(Date.today - 1))
      self.assert_index(user.work.where_week(Date.today))
      self.assert_index(user.work.where_started)

      self.assert_index(task.work.where_date(Date.today))

    end

    protected

      def on_before_save
        if self.task_id_changed?
          self._project_name = self.task.project.name.downcase
          self._activity_name = self.task.activity.name.downcase
        end
      end

      def on_before_destroy
        if self.started?
          self.duration = (self.duration || 0) + ( Time.now - self.updated ).to_i
          self.started = nil
          self.updated = nil
        end
      end

  end

end
