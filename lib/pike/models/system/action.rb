require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    class Action
      include Mongoid::Document
      include Mongoid::Timestamps

      store_in :system_actions

      field :exception_at, :type => Time
      field :exception_class, :type => String
      field :exception_message, :type => String
      field :exception_backtrace, :type => Array

      default_scope order_by([:created_at, :asc])

      scope :where_not_executed, where(:exception_at => nil)
      scope :where_failed, where(:exception_at.ne => nil)

      def execute!
        begin
          self.execute
        rescue => exception
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
