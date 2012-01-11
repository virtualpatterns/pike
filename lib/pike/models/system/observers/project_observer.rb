require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ProjectObserver < Mongoid::Observer
        observe Pike::Project

      end

    end

  end

end
