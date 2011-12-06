$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. lib]))

require 'rubygems'
require 'bundler/setup'

require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'capybara/rspec/matchers'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :chrome
Capybara.app_host = 'http://localhost:8008'

World(Capybara)

require 'pike/application'

Pike::Application.create_default!