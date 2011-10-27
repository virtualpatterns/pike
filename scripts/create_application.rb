puts "Running #{__FILE__.inspect}"

require 'rubygems'
require 'bundler/setup'

require 'pike/application'
require 'pike/session'

options = { :application_class => Pike::Application,
            :session_class => Pike::Session,
            :log_path => File.join(File.dirname(__FILE__), %w[.. log application.log]),
            :configuration_paths => File.join(File.dirname(__FILE__), %w[.. config.yml]),
            :theme => 'ruby_app/themes/mobile',
            :default_language => :en,
            :translations_paths => File.join(File.dirname(__FILE__), %w[.. translations]) }

Pike::Application.create options
