require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  class Introduction
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    store_in :introductions

    belongs_to :introduction_from, :class_name => 'Pike::User', :inverse_of => :introductions_to
    belongs_to :introduction_to,   :class_name => 'Pike::User', :inverse_of => :introductions_from

    validates_presence_of :introduction_from
    validates_presence_of :introduction_to

    field :message, :type => String, :default => 'Be my friend!'

    def accept!
      self.introduction_from.push(:friend_ids, self.introduction_to.id) unless self.introduction_from.friends.include?(self.introduction_to)
      self.introduction_to.push(:friend_ids, self.introduction_from.id) unless self.introduction_to.friends.include?(self.introduction_from)
      self.destroy!
    end

    def reject!
      self.destroy!
    end

  end

end
