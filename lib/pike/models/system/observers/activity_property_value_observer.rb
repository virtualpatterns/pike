require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ActivityPropertyValueObserver < Mongoid::Observer
        observe Pike::ActivityPropertyValue

        def around_save(value)
          if value.changes.include?(:value) 
            yield
            Pike::System::Actions::ActivityPropertyValueCopyAction.create!(:user_source => value.activity.user,
                                                                           :user_target => nil,
                                                                           :value => value) unless value.copy?
          else
            yield
          end
          return true
        end

        def around_destroy(value)
          _values = value.copies.all.collect
          yield
          _values.each do |_value|
            Pike::System::Actions::ActivityPropertyValueDeleteAction.create!(:user_source => nil,
                                                                             :user_target => nil,
                                                                             :value => _value)
          end
          return true
        end

      end

    end

  end

end
