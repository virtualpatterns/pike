require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ActivityObserver < Mongoid::Observer
        observe Pike::Activity

      end

    end

  end

end
