require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System
    require 'pike/mixins'

    class Message
      include Mongoid::Document
      include Mongoid::Timestamps
      extend Pike::Mixins::IndexMixin

      store_in :system_messages

      has_many :message_states, :class_name => 'Pike::System::MessageState'

      field :subject, :type => String
      field :body, :type => String

      validates_presence_of :subject
      validates_presence_of :body

      default_scope order_by([[:created_at, :desc]])

      scope :created_since, lambda { |date| where(:created_at.gte => date) }

      index [[:created_at,  1]]

      def self.assert_indexes
        message1 = Pike::System::Message.create_message!('Assert Indexes Message Subject 1', 'Assert Indexes Message Body 1')
        sleep(5)
        message2 = Pike::System::Message.create_message!('Assert Indexes Message Subject 2', 'Assert Indexes Message Body 2')

        self.assert_index(Pike::System::Message.created_since(message2.created_at))

      end

      def self.create_message!(subject, body)
        Pike::System::Message.create!(:subject  => subject,
                                      :body     => body)
      end

    end

  end

end
