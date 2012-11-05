require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System
    require 'pike/mixins'

    class Sequence
      include Mongoid::Document

      store_in :system_sequences

      field :count, :type => Integer, :default => 0

      default_scope order_by([:_id, :asc])

      def self.next(name)
        return self.collection.find_and_modify(:query  => {'_id' => name},
                                               :update => {'$inc' => {'count' => 1}},
                                               :new    => true,
                                               :upsert => true)['count']
      end

    end

  end

end
