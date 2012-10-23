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

      store_in :system_actions

      field :index, :type => Integer, :default => lambda { Pike::System::Sequence.next('Pike::System::Action#index') }

      field :failed, :type => Boolean, :default => false
      field :exception_at, :type => Time
      field :exception_class, :type => String
      field :exception_message, :type => String
      field :exception_backtrace, :type => Array

      default_scope order_by([:index, :asc])

      scope :where_not_executed, where(:exception_at => nil)
      scope :where_failed, where(:failed => true)

      index [[:failed,       1],
             [:index,        1]], { :background => true }

      index [[:index,        1]]

      def self.assert_indexes
        Pike::System::Actions::EmptyAction.create!

        self.assert_index(Pike::System::Action.all)
        self.assert_index(Pike::System::Action.where_not_executed)

        Pike::System::Action.execute_all!

        self.assert_index(Pike::System::Action.where_failed)

      end

      def failed?
        return self.failed
      end

      def execute!
        begin
          self.execute
        rescue => exception
          self.failed = true
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
        Pike::System::Action.where_not_executed.each do |action|
          action.execute!
        end
      end

    end

  end

end
