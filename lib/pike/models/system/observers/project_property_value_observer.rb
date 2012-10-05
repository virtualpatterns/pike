require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ProjectPropertyValueObserver < Mongoid::Observer
        observe Pike::ProjectPropertyValue

        def around_save(value)
          create_action = value.value_changed?
          yield
          Pike::System::Actions::ProjectPropertyValueCopyAction.create!(:user_source => value.project.user,
                                                                        :user_target => nil,
                                                                        :value => value) if create_action unless value.copy_of
        end

        def around_destroy(value)
          # TODO ... index values.copies.all
          _values = value.copies.all.collect
          yield
          _values.each do |_value|
            Pike::System::Actions::ProjectPropertyValueDeleteAction.create!(:user_source => nil,
                                                                            :user_target => nil,
                                                                            :value => _value)
          end
        end

      end

    end

  end

end
