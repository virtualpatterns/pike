require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System
    require 'pike/mixins'

    class MessageState
      include Mongoid::Document
      include Mongoid::Timestamps
      extend Pike::Mixins::IndexMixin

      store_in :message_states

      STATE_NEW   = 0
      STATE_READ  = 1
      STATE_NAMES = { Pike::System::MessageState::STATE_NEW   => 'New',
                      Pike::System::MessageState::STATE_READ  => 'Read' }

      belongs_to :user, :class_name => 'Pike::User'
      belongs_to :message, :class_name => 'Pike::System::Message'

      field :state, :type => Integer, :default => Pike::System::MessageState::STATE_NEW

      validates_presence_of :state
      validates_uniqueness_of :message_id, :scope => [:user_id]

      default_scope order_by([:created_at, :desc])

      scope :where_message, lambda { |message| where(:message_id => message.id) }
      scope :where_new, where(:state => Pike::System::MessageState::STATE_NEW)

      index [[:user_id,     1],
             [:message_id,  1],
             [:state,       1],
             [:created_at,  1]]

      def self.assert_indexes
        user = Pike::User.get_user_by_url('Assert Indexes User')

        message1 = Pike::System::Message.create_message!('Assert Indexes Message Subject 1', 'Assert Indexes Message Body 1')
        message2 = Pike::System::Message.create_message!('Assert Indexes Message Subject 2', 'Assert Indexes Message Body 2')

        Pike::System::Action.execute_all!

        self.assert_index(user.message_states.where_message(message1))

        message_state = user.message_states.where_message(message1).first
        message_state.read!

        self.assert_index(user.message_states.where_new)

      end

      def read!
        self.state = Pike::System::MessageState::STATE_READ
        self.save!
      end

    end

  end

end
