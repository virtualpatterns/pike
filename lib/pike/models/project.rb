require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Project
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :projects

    before_save :on_before_save
    after_save :on_after_save
    before_destroy :on_before_destroy

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    field :name, :type => String
    field :_name, :type => String

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :deleted_at]

    default_scope order_by([:_name, :asc])

    def exists_tasks?
      self.tasks.all.count > 0
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
