require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    class Action
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Paranoia

      store_in :system_actions

      ACTION_SYNC   = 0
      ACTION_NAMES  = { Pike::System::Action::ACTION_SYNC => 'Sync' }

      belongs_to :user_source, :class_name => 'Pike::User', :inverse_of => :actions_as_source
      belongs_to :user_target, :class_name => 'Pike::User', :inverse_of => :actions_as_target

      field :action, :type => Integer, :default => Pike::System::Action::ACTION_SYNC

      validates_presence_of :user_source
      validates_presence_of :action

      default_scope order_by([:created_at, :asc])

    end

  end

end
