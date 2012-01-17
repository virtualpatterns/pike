require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[..]))

require 'pike/application'
require 'pike/models'
require 'pike/version'

Pike::Application.create_default!

while true
  RubyApp::Log.debug("Pike::System::Action.all at #{Time.now}")
  Pike::System::Action.all.each do |action|
    begin
      action.process!
    rescue Exception => exception
      RubyApp::Log.exception(exception)
    end
  end
  sleep(60)
end
