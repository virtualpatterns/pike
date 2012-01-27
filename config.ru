#\ -o 0.0.0.0 -p 8008 -P ./rack.pid

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app/rack/application'
require 'ruby_app/rack/route'
require 'ruby_app/version'

require 'pike/application'
require 'pike/session'
require 'pike/version'

use Rack::ShowExceptions
use Rack::Session::Pool
use Rack::Reloader
use Rack::ContentLength

use RubyApp::Rack::Application, :application_class => Pike::Application,
                                :session_class => Pike::Session,
                                :log_path => File.join(Pike::ROOT, %w[process log application.log]),
                                :configuration_paths => File.join(Pike::ROOT, %w[config.yml]),
                                :default_language => :en,
                                :translations_paths => File.join(Pike::ROOT, %w[translations])
run RubyApp::Rack::Route.new

map '/favicon.ico' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map '/ruby_app/resources' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

map '/pike/resources' do
  run Rack::File.new(File.join(Pike::ROOT, %w[resources]))
end
