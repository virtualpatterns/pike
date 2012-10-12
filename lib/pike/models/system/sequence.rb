require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    class Sequence
      include Mongoid::Document

      def self.next(name)
        collection = self.db.collection(:system_sequences)
        document = collection.find_and_modify(:query  => {'_id' => name},
                                              :update => {'$inc' => {'count' => 1}},
                                              :new    => true,
                                              :upsert => true)
        return document['count']
      end

    end

  end

end
