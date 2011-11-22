require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Work
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :work

    after_save :on_after_save
    before_destroy :on_before_destroy

    belongs_to :user, :class_name => 'Pike::User'
    belongs_to :task, :class_name => 'Pike::Task'

    validates_presence_of :user
    validates_presence_of :task

    field :date, :type => Date
    field :duration, :type => Integer, :default => 0
    field :started, :type => Time
    field :updated, :type => Time

    validates_presence_of :date

    validates_uniqueness_of :task_id, :scope => [:date, :deleted_at]

    scope :where_date, lambda { |date| where(:date => date) }
    scope :where_not_date, lambda { |date| where(:date.ne => date) }
    scope :where_started, where(:started.ne => nil)
    scope :except, lambda { |work| where(:_id.ne => work.id) }

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

    def update_duration!
      if self.started?
        self.duration = (self.duration || 0) + ( Time.now - self.updated ).to_i
        self.updated = Time.now
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

    def self.round_to_minute(duration)
      (duration/60).round * 60
    end

    protected

      def on_after_save
        unless self.duration
          self.destroy!
        end
      end

      def on_before_destroy
        if self.started?
          self.started = nil
          self.updated = nil
        end
      end

  end

end
