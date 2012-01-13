require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

module Pike

  module System

    module Actions

      class ProjectAction < Pike::System::Action

        belongs_to :project, :class_name => 'Pike::Project'

        def process!
          RubyApp::Log.debug("#{self.class}##{__method__} self.user_source.url=#{self.user_source ? self.user_source.url.inspect : '(nil)'} self.user_target.url=#{self.user_target ? self.user_target.url.inspect : '(nil)'} self.project.name=#{self.project ? self.project.name.inspect : '(nil)'}")
          case self.action
            when Pike::System::Action::ACTION_SYNC
              # Sync
              unless self.user_target
                # Sync to all friends
                self.user_source.friendships_as_source.each do |friendship|
                  unless self.project
                    # Sync all shared projects to a friend
                    self.sync_shared_projects_to_friend(friendship.user_target)
                  else
                    # Sync a specific project to a friend
                    self.sync_project_to_friend(self.project, friendship.user_target)
                  end
                end
              else
                # Sync to a specific user
                if self.user_source.friendships_as_source.where_user_target(self.user_target).exists?
                  # Sync to a friend
                  unless self.project
                    # Sync all shared projects to a friend
                    self.sync_shared_projects_to_friend(self.user_target)
                  else
                    # Sync a specific project to a friend
                    self.sync_project_to_friend(self.project, self.user_target)
                  end
                else
                  # Sync all shared projects to a non-friend
                  self.sync_shared_projects_to_non_friend(self.user_target)
                end
              end
            when Pike::System::Action::ACTION_DELETE
              # Delete
              self.delete_project(self.project)
          end
          self.destroy
        end

        def sync_shared_projects_to_friend(user)
          self.user_source.projects.where_shared.each do |project|
            self.sync_project_to_friend(project, user)
          end
        end

        def sync_project_to_friend(project, user)
          if project.shared?
            # Add or update the friend's project
            self.add_update_project_to_user(project, user)
          else
            # Delete the friend's project
            self.delete_project_from_user(project, user)
          end
        end

        def sync_shared_projects_to_non_friend(user)
          self.user_source.projects.where_shared.each do |project|
            self.sync_project_to_non_friend(project, user)
          end
        end

        def sync_project_to_non_friend(project, user)
          self.delete_project_from_user(project, user)
        end

        def add_update_project_to_user(project, user)
          projects = user.projects.where_copy_of(project)
          unless projects.exists?
            self.add_project_to_user(project, user)
          else
            projects.each do |_project|
              self.update_project(project, _project)
            end
          end
        end

        def add_project_to_user(project, user)
          RubyApp::Log.debug("#{self.class}##{__method__} project.name=#{project.name.inspect} user.url=#{user.url.inspect}")
          user.projects.create!(:copy_of => project,
                                :name => project.name,
                                :is_shared => false)
        end

        def update_project(project, _project)
          RubyApp::Log.debug("#{self.class}##{__method__} project.name=#{project.name.inspect} _project.name=#{_project.name.inspect}")
          _project.name = project.name
          _project.save!
        end

        def delete_project_from_user(project, user)
          user.projects.where_copy_of(project).each do |_project|
            RubyApp::Log.debug("#{self.class}##{__method__} user.url=#{user.url.inspect} _project.name=#{_project.name.inspect}")
            self.delete_project(_project)
          end
        end

        def delete_project(project)
          RubyApp::Log.debug("#{self.class}##{__method__} _project.name=#{project.name.inspect}")
          project.tasks.each do |task|
            task.destroy
          end
          project.destroy
        end

      end

    end

  end

end
