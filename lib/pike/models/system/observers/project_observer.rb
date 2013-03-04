require 'rubygems'
require 'bundler/setup'

require 'mongoid'

module Pike

  module System

    module Observers
      require 'pike/models'

      class ProjectObserver < Mongoid::Observer
        observe Pike::Project

        def around_save(project)
          if project.changes.include?(:name) ||
             project.changes.include?(:is_shared)
            yield
            Pike::System::Actions::ProjectCopyAction.create!(:user_source => project.user,
                                                             :user_target => nil,
                                                             :project => project) unless project.copy?
          else
            yield
          end
          return true
        end

        def around_destroy(project)
          _projects = project.copies.all.collect
          yield
          _projects.each do |_project|
            Pike::System::Actions::ProjectDeleteAction.create!(:user_source => nil,
                                                               :user_target => nil,
                                                               :project => _project)
          end
          return true
        end

      end

    end

  end

end
