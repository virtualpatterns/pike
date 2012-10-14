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

      field :subject, :type => String
      field :body, :type => String

      validates_presence_of :subject
      validates_presence_of :body

      default_scope order_by([[:created_at, :desc]])

      scope :where_unread, lambda { |user| where(:created_at.gt => user.created_at).and(:_id.nin => user.read_messages) }

      index [[:created_at,  1],
             [:_id,         1]]

      def self.assert_indexes
        message = Pike::System::Message.create_message!('Assert Indexes Message Subject', 'Assert Indexes Message Body')
        user = Pike::User.get_user_by_url('Assert Indexes User')

        self.assert_index(Pike::System::Message.where_unread(user))

      end

      def self.create_message!(subject, body)
        Pike::System::Message.create!(:subject  => subject,
                                      :body     => body)
      end

    end

  end

end
