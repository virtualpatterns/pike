require 'rubygems'
require 'bundler/setup'

require 'mongoid'

require 'ruby_app'

module Pike

  module System
    require 'pike/mixins'

    class Migration
      include Mongoid::Document
      include Mongoid::Timestamps
      extend Pike::Mixins::IndexMixin

      store_in :system_migrations

      field :name, :type => String
      field :count, :type => Integer, :default => 0

      validates_presence_of :name
      validates_uniqueness_of :name, :scope => :deleted_at

      default_scope order_by([:name, :asc])

      scope :where_name, lambda { |name| where(:name => name) }

      index [[:name, 1]], { :unique => true }

      def self.assert_indexes
        Pike::System::Migration.create_migration!('Assert Indexes Migration')

        self.assert_index(Pike::System::Migration.all)
        self.assert_index(Pike::System::Migration.where_name('Assert Indexes Migration'))

      end

      def self.create_migration!(name)
        return Pike::System::Migration.where_name(name).first || Pike::System::Migration.create!(:name => name)
      end

      def self.run(name, force = false)
        migration = Pike::System::Migration.where_name(name).first
        if !migration || force
          puts '-' * 80
          puts "#{name} force=#{force}"
          puts '-' * 80
          yield if block_given?
          puts '-' * 80
          migration = Pike::System::Migration.create!(:name => name) unless migration
          migration.count += 1
          migration.save!
        end
        return migration
      end

    end

  end

end
