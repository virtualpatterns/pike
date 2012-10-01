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
          create_action = property.name_changed? ? true : false
          yield
          Pike::System::Actions::PropertyCopyAction.create!(:user_source => property.user,
                                                            :user_target => nil,
                                                            :property => property) if create_action unless property.copy_of
        end

        def around_destroy(property)
          _properties = property.copies.all.collect
          yield
          _properties.each do |_property|
            Pike::System::Actions::PropertyDeleteAction.create!(:user_source => nil,
                                                                :user_target => nil,
                                                                :property => _property)
          end
        end

      end

    end

  end

end
