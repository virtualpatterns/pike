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
          RubyApp::Log.debug("#{self.class}##{__method__} project.name=#{project.name.inspect}")
          create_action = ( project.name_changed? || project.is_shared_changed? ) ? true : false
          yield
          Pike::System::Actions::ProjectAction.create!(:user_source => project.user,
                                                       :user_target => nil,
                                                       :action => Pike::System::Action::ACTION_SYNC,
                                                       :project => project) if create_action unless project.copy_of
        end

        def around_destroy(project)
          RubyApp::Log.debug("#{self.class}##{__method__} project.name=#{project.name.inspect}")
          _projects = project.copies.collect
          yield
          _projects.each do |_project|
            Pike::System::Actions::ProjectAction.create!(:user_source => nil,
                                                         :user_target => nil,
                                                         :action => Pike::System::Action::ACTION_DELETE,
                                                         :project => _project)
          end
        end

      end

    end

  end

end
