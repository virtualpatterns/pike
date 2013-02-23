#\ --warn --port 8000 --pid ./rack.pid
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app'
require 'ruby_app/rack'

require 'pike'

RubyApp::Application.root = '/pike'

use Rack::ShowExceptions
use Rack::Reloader

#use RubyApp::Rack::Duration
#use RubyApp::Rack::Memory

use RubyApp::Rack::Application, :configuration_paths  => [ File.join(RubyApp::ROOT, %w[configuration.yml]),
                                                           File.join(Pike::ROOT, %w[configuration.yml])]

map "#{RubyApp::Application.root_or_nil}/ruby_app/resources" do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

map "#{RubyApp::Application.root_or_nil}/pike/resources" do
  run Rack::File.new(File.join(Pike::ROOT, %w[resources]))
end

map "#{RubyApp::Application.root_or_nil}/favicon.ico" do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map "#{RubyApp::Application.root_or_nil}/robots.txt" do
  run Rack::File.new(File.join(Pike::ROOT, %w[resources robots.txt]))
end

map "#{RubyApp::Application.root_or_nil}/" do
  use RubyApp::Rack::Request
  use RubyApp::Rack::Response
  use RubyApp::Rack::Language
  use RubyApp::Rack::Session
  run RubyApp::Rack::Route.new
end
