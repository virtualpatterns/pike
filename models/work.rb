require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Work
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :work

    belongs_to :user, :class_name => 'Pike::User'
    belongs_to :task, :class_name => 'Pike::Task'

    validates_presence_of :user
    validates_presence_of :task

    field :date, :type => Date
    field :duration, :type => Integer, :default => 0
    field :started, :type => Time
    field :updated, :type => Time

    validates_presence_of :date
    validates_presence_of :duration

    validates_uniqueness_of :task_id, :scope => [:date, :deleted_at]

    scope :where_date, lambda { |date| where(:date => date) }
    scope :where_started, where(:started.ne => nil)
    scope :except, lambda { |work| where(:_id.ne => work.id) }

    def self.round_to_minute(duration)
      (duration/60).round * 60
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

    def update_duration!
      if self.started?
        self.duration += ( Time.now - self.updated ).to_i
        self.updated = Time.now
        self.save!
      end
    end

    def finish!
      if self.started?
        self.duration += ( Time.now - self.updated ).to_i
        self.started = nil
        self.updated = nil
        self.save!
      end
    end

  end

end
