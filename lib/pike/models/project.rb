require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Project
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :projects

    after_save :on_after_save
    before_destroy :on_before_destroy

    belongs_to :user, :class_name => 'Pike::User'
    has_many :tasks, :class_name => 'Pike::Task'

    field :name, :type => String

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => [:user_id, :deleted_at]

    default_scope order_by([:name, :asc])

    def exists_tasks?
      self.tasks.all.count > 0
    end

    protected

      def on_after_save
        self.tasks.all.each do |task|
          task.save
        end
      end
    
      def on_before_destroy
        if exists_tasks?
          raise 'The selected project cannot be deleted.  The project is assigned to a task.'
        end
      end

  end

end
