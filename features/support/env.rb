require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :chrome
Capybara.app_host = 'http://localhost:8008'

World(Capybara)
