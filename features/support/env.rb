$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. lib]))

require 'rubygems'
require 'bundler/setup'

require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'capybara/rspec/matchers'

Capybara.register_driver :pike do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :resynchronize => true)
end

Capybara.default_driver = :pike
Capybara.app_host = 'http://localhost:8008'

World(Capybara)

require 'ruby_app'
require 'pike'

RubyApp::Configuration.load!([ File.join(RubyApp::ROOT, %w[configuration.yml]),
                               File.join(Pike::ROOT, %w[configuration.yml])])
RubyApp::Log.open!
RubyApp::Application.create!

at_exit do
  RubyApp::Application.destroy!
  RubyApp::Log.close!
  RubyApp::Configuration.unload!
end
