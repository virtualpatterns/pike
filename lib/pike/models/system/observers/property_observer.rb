require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class PropertyObserver < Mongoid::Observer
        observe Pike::Property

        def around_save(property)
          if property.changes.include?('name')
            yield
            Pike::System::Actions::PropertyCopyAction.create!(:user_source => property.user,
                                                              :user_target => nil,
                                                              :property => property) unless property.copy?
          else
            yield
          end
          return true
        end

        def around_destroy(property)
          _properties = property.copies.all.collect
          yield
          _properties.each do |_property|
            Pike::System::Actions::PropertyDeleteAction.create!(:user_source => nil,
                                                                :user_target => nil,
                                                                :property => _property)
          end
          return true
        end

      end

    end

  end

end
