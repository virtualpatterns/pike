require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Activity
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :activities

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    has_many :actions, :class_name => 'Pike::System::Actions::ActivityAction'

    has_many   :copies,  :class_name => 'Pike::Activity', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Activity', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    field :name, :type => String
    field :_name, :type => String
    field :is_shared, :type => Boolean, :default => false

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :copy_of_id, :deleted_at]

    default_scope order_by([:_name, :asc])

    scope :where_shared, where(:is_shared => true)
    scope :where_copy_of, lambda { |project| where(:copy_of_id => project.id) }

    def shared?
      self.is_shared
    end

    def exists_tasks?
      self.tasks.exists?
    end

    protected

      def on_before_save
        self._name = self.name.downcase if self.name_changed?
      end

      def on_after_save
        if self.name_changed?
          self.tasks.all.each do |task|
            task.set(:_activity_name, self.name.downcase)
          end
        end
      end

      def on_before_destroy
        raise 'The selected activity cannot be deleted.  The activity is assigned to a task.' if exists_tasks?
      end

  end

end
