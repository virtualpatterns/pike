require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    class Action
      include Mongoid::Document
      include Mongoid::Timestamps

      store_in :system_actions

      default_scope order_by([:created_at, :asc])

      def process!
      end

    end

  end

end
