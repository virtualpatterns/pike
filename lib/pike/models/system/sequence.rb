require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    class Sequence
      include Mongoid::Document

      store_in :collection => :system_sequences

      field :count, :type => Integer, :default => 0

      default_scope order_by([:_id, :asc])

      scope :where_name, lambda { |name| where(:_id => name ? name.downcase : nil) }

      def self.next(name = 'Pike::System::Sequence#count')
        return self.where_name(name).find_and_modify({'$inc' => {'count' => 1}}, :new => true,
                                                                                 :upsert => true).count
      end

    end

  end

end
