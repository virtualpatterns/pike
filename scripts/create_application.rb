puts "Running #{__FILE__.inspect}"

require 'pike/application'
require 'pike/session'

options = { :application_class => Pike::Application,
            :session_class => Pike::Session,
            :log_path => File.join(Pike::ROOT, %w[log application.log]),
            :configuration_paths => File.join(Pike::ROOT, %w[config.yml]),
            :default_language => :en,
            :translations_paths => File.join(Pike::ROOT, %w[translations]) }

Pike::Application.create! options
