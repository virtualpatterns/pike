require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System
    require 'pike/mixins'

    class Action
      include Mongoid::Document
      include Mongoid::Timestamps
      extend Pike::Mixins::IndexMixin

      store_in :collection => :system_actions

      STATE_PENDING   = 0
      STATE_EXECUTED  = 1
      STATE_NAMES     = { Pike::System::Action::STATE_PENDING   => 'Pending',
                          Pike::System::Action::STATE_EXECUTED  => 'Executed' }

      field :state, :type => Integer, :default => Pike::System::Action::STATE_PENDING
      field :index, :type => Integer, :default => lambda { Pike::System::Sequence.next('Pike::System::Action#index') }

      field :exception_at, :type => Time
      field :exception_class, :type => String
      field :exception_message, :type => String
      field :exception_backtrace, :type => Array

      validates_presence_of :state
      validates_presence_of :index

      default_scope order_by([:index, :asc])

      scope :where_pending, where(:state => Pike::System::Action::STATE_PENDING)

      def self.assert_indexes
        action1 = Pike::System::Actions::EmptyAction.create!
        action1.execute!

        action2 = Pike::System::Actions::EmptyAction.create!

        self.assert_index(Pike::System::Action.all)
        self.assert_index(Pike::System::Action.where_pending)

      end

      def execute!
        begin
          self.execute
        rescue => exception
          self.state = Pike::System::Action::STATE_EXECUTED
          self.exception_at = Time.now
          self.exception_class = exception.class
          self.exception_message = exception.message
          self.exception_backtrace = exception.backtrace
          self.save!
        else
          self.destroy
        end
      end

      def execute
      end

      def self.execute_all!
        Pike::System::Action.where_pending.each do |action|
          action.execute!
        end
      end

    end

  end

end
