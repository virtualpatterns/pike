$ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.]))
$LOAD_PATH.unshift $ROOT unless $LOAD_PATH.include?($ROOT)

require 'application'
require 'session'

puts "Running #{__FILE__.inspect}"

options = { :application_class => Pike::Application,
            :session_class => Pike::Session,
            :log_path => File.join(Pike::ROOT, %w[log application.log]),
            :configuration_paths => File.join(Pike::ROOT, %w[config.yml]),
            :default_language => :en,
            :translations_paths => File.join(Pike::ROOT, %w[translations]) }

Pike::Application.create options
