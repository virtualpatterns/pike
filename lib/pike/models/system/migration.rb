require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app/log'

module Pike

  module System

    class Migration
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Paranoia

      store_in :system_migrations

      field :name, :type => String

      validates_presence_of :name
      validates_uniqueness_of :name, :scope => :deleted_at

      scope :where_name, lambda { |name| where(:name => name) }

      def self.run(name)
        migration = Pike::System::Migration.where_name(name).first
        unless migration
          puts '-' * 80
          puts name
          puts '-' * 80
          yield if block_given?
          puts '-' * 80
          migration = Pike::System::Migration.create!(:name => name)
        end
        return migration
      end

    end

  end

end
