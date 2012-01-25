require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Project
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in :projects

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    has_many :synchronize_actions, :class_name => 'Pike::System::Actions::ProjectSynchronizeAction'

    has_many   :copies,  :class_name => 'Pike::Project', :inverse_of => :copy_of
    belongs_to :copy_of, :class_name => 'Pike::Project', :inverse_of => :copies

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    field :name, :type => String
    field :_name, :type => String
    field :is_shared, :type => Boolean, :default => false

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :copy_of_id]

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
            task.set(:_project_name, self.name.downcase)
          end
        end
      end

      def on_before_destroy
        raise 'The selected project cannot be deleted.  The project is assigned to a task.' if exists_tasks?
      end

  end

end
